import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleController(),
      child: const MeozApp(),
    ),
  );
}

class MeozApp extends StatelessWidget {
  const MeozApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lc = context.watch<LocaleController>();
    return MaterialApp(
      title: 'M.E.O.Z LABORATOIRE',
      debugShowCheckedModeBanner: false,
      theme: meozTheme,
      locale: lc.locale,
      supportedLocales: const [Locale('fr'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}
