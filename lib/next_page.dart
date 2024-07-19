import 'package:delta/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'transition_route_state.dart';
import 'next_page.dart';
import 'sign.dart';

  class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            'Login 로그인',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
       ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Image.asset(
                  width: 500,
                  height: 200,
                  "assets/images/LogoIcon.png"),

              TextField(
                decoration: InputDecoration(
                  labelText: "ID",
                  border: const OutlineInputBorder(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),

                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>MyHomePage())
                    );
                  },
                  child: Text('Login'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Sign())
                    );
                  },
                  child: Text('회원가입 하러가기'),
                ),
              ),
            ],
          ),
        ),
    ),
    );
    }
}

Sign() {
}
