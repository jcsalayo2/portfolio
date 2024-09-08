import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const Home(title: 'Portfolio'),
    );
  }
}
