import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// A key/value string storage encrypted at rest with a locally generated
/// AES key.
///
/// This is *not* as secure as an OS keychain/keyring: the key lives next to
/// the encrypted data, so anyone with local file access to the user's
/// profile can decrypt it. It only protects against casual inspection of
/// the data file (e.g. accidental sharing, cloud backup of app data).
/// It exists as a fallback for environments where the system secret
/// service is unavailable or locked (e.g. Live USB sessions, minimal
/// desktop environments without a keyring daemon).
class LocalEncryptedStorage {
  static const _dataFileName = 'secure_fallback.dat';
  static const _keyFileName = 'secure_fallback.key';

  Future<Directory> _storageDir() async {
    final dir = await getApplicationSupportDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<encrypt.Key> _loadOrCreateKey(Directory dir) async {
    final keyFile = File(p.join(dir.path, _keyFileName));

    if (await keyFile.exists()) {
      final bytes = base64Decode(await keyFile.readAsString());
      return encrypt.Key(bytes);
    }

    final key = encrypt.Key.fromSecureRandom(32);
    await keyFile.writeAsString(base64Encode(key.bytes));
    // Restrict access to the owner only, best-effort (no-op on Windows).
    try {
      await Process.run('chmod', ['600', keyFile.path]);
    } catch (_) {
      // Best effort; not fatal if chmod is unavailable (e.g. Windows).
    }
    return key;
  }

  Future<Map<String, String>> _readAll() async {
    final dir = await _storageDir();
    final dataFile = File(p.join(dir.path, _dataFileName));

    if (!await dataFile.exists()) return {};

    final key = await _loadOrCreateKey(dir);
    final raw = await dataFile.readAsString();
    final parts = raw.split(':');
    if (parts.length != 2) return {};

    final iv = encrypt.IV.fromBase64(parts[0]);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    final decrypted = encrypter.decrypt64(parts[1], iv: iv);

    return Map<String, String>.from(jsonDecode(decrypted) as Map);
  }

  Future<void> _writeAll(Map<String, String> values) async {
    final dir = await _storageDir();
    final dataFile = File(p.join(dir.path, _dataFileName));
    final key = await _loadOrCreateKey(dir);

    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    final encrypted = encrypter.encrypt(jsonEncode(values), iv: iv);

    await dataFile.writeAsString('${iv.base64}:${encrypted.base64}');
  }

  Future<String?> read(String key) async {
    final values = await _readAll();
    return values[key];
  }

  Future<void> write(String key, String value) async {
    final values = await _readAll();
    values[key] = value;
    await _writeAll(values);
  }

  Future<void> delete(String key) async {
    final values = await _readAll();
    if (values.remove(key) != null) {
      await _writeAll(values);
    }
  }
}
