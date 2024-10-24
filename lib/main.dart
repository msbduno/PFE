import 'package:flutter/material.dart';
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/record_page.dart';
import 'presentation/pages/profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESEOSPORT',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/record': (context) => RecordPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}