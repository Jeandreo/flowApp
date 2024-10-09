import 'package:meu_financeiro_organizado/routes/app_routes.dart';
import 'package:meu_financeiro_organizado/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sulink Grow',
      theme: buildThemeData(context),
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      onGenerateRoute: AppRoutes.generateRoute,
      home: const HomeScreen(),
    );
  }
}
