import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:rich_chess_notes/i18n/strings.g.dart';
import 'package:rich_chess_notes/pages/home.dart';
import 'package:rich_chess_notes/providers/dark_theme_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    await windowManager.ensureInitialized();
    await windowManager.setTitle('Rich chess notes');
  }

  runApp(ProviderScope(child: TranslationProvider(child: const MainApp())));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    // simple_chess_board accesses `SoLoud.instance` in a field initializer,
    // unguarded by try/catch. That first access loads the native audio
    // library via FFI; if it happens to fail exactly when a chessboard is
    // first built (e.g. right after creating a note), the exception isn't
    // caught and Flutter shows an error screen. Pre-warm it here, during the
    // splash screen, so that risky first access already happened safely by
    // the time any chessboard widget is built.
    try {
      await SoLoud.instance.init();
    } catch (e) {
      debugPrint('Failed to pre-initialize SoLoud: $e');
    }

    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final inDarkMode = ref.watch(darkThemeProvider);
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeWidget()),
      theme: FlexThemeData.light(scheme: FlexScheme.greenM3),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueWhale),
      themeMode: inDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
