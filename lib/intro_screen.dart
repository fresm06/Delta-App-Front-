import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3afbd8),
              Color(0xFFa965fe),
            ]
          )
        ),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}