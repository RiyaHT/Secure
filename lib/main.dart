import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_app/customProvider.dart';
import 'package:secure_app/login.dart';
import 'package:secure_app/splash.dart';

import 'layout.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => const LayoutScreen(),
        '/login': (context) => const LoginScreen(),
      },
      // home: const SplashScreen(),
    );
  }
}
