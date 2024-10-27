import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ESEOSPORT',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 2,
                  color: Colors.white,
                ),

                const Text(
                  '    BY    ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                  ),
                ),
                Container(
                  width: 120,
                  height: 2,
                  color: Colors.white,
                ),
              ],
            ),
            Image.asset(
              "assets/ESEO.png",
              width: 180,
              height: 155,
            )
          ],
        ),
      ),
    );
  }
}