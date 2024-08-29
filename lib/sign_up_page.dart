import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "회원가입",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                "assets/images/LogoIcon.png",
                width: 250,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "ID",
                hintText: "ID를 입력해주세요.",
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "비밀번호",
                hintText: "비밀번호를 입력해주세요.",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "이메일",
                hintText: "이메일을 입력해주세요.",
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  print("sign up");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
