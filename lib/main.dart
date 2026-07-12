import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
