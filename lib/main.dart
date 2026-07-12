import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_chess_notes/i18n/strings.g.dart';
import 'package:rich_chess_notes/pages/home.dart';
import 'package:rich_chess_notes/providers/dark_theme_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    await windowManager.ensureInitialized();
    await windowManager.setTitle('Rich chess notes');
  }

  runApp(ProviderScope(child: TranslationProvider(child: const MainApp())));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
