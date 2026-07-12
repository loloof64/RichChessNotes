import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2_client/interfaces.dart';
import 'package:rich_chess_notes/services/local_encrypted_storage.dart';

/// A key/value string storage that uses the OS secret service
/// ([FlutterSecureStorage]) when available, and transparently falls back to
/// [LocalEncryptedStorage] otherwise (e.g. locked/unavailable keyring on
/// Linux, common on Live USB sessions or minimal desktop environments).
///
/// Also implements oauth2_client's [BaseStorage] so it can be injected
/// directly into its `TokenStorage`.
class ResilientSecureStorage implements BaseStorage {
  ResilientSecureStorage({
    FlutterSecureStorage? secureStorage,
    LocalEncryptedStorage? fallbackStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _fallbackStorage = fallbackStorage ?? LocalEncryptedStorage();

  final FlutterSecureStorage _secureStorage;
  final LocalEncryptedStorage _fallbackStorage;

  @override
  Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('Secure storage read failed, using local fallback: $e');
      return _fallbackStorage.read(key);
    }
  }

  @override
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('Secure storage write failed, using local fallback: $e');
      await _fallbackStorage.write(key, value);
    }
  }

  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('Secure storage delete failed, using local fallback: $e');
    }
    // Always clear the fallback copy too, in case it was used previously.
    await _fallbackStorage.delete(key);
  }
}
