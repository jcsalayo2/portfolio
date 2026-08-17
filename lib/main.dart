import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/theme/portfolio_scroll_behavior.dart';
import 'package:portfolio/theme/portfolio_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: buildPortfolioTheme(),
      scrollBehavior: const PortfolioScrollBehavior(),
      home: const SafeArea(
        child: SelectionArea(child: Home(title: 'Portfolio')),
      ),
    );
  }
}
