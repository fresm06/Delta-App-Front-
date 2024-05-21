import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Delta',
            style: TextStyle(
                fontFamily: 'cafe24',
                fontSize: 40
            ),
          ),
          shadowColor: Colors.black,
        ),
        body: Container(
          child: SingleChildScrollView(
            child:RefreshIndicator()
              child: Column(
                children: [
                  Text(
                    '대충 오늘 공부시간 1등',
                    style: TextStyle(
                        fontFamily: 'cafe24',
                        fontSize: 20
                    ),
                  ),
                  film(),
                  film(),
                  film(),
                  film(),
                  film()
                ]
              ),
          ),
        ),
      ),
    );
  }
}

class film extends StatelessWidget {
  const film({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          AppBar(leading: Image.asset('assets/images/testprofile.png', width: 10, height: 10), title: Text('귀여운 고양이', style: TextStyle(fontFamily: 'cafe24'))),
          Image.asset('assets/images/mrfresh.jpg'),
          AppBar(leading: Icon(Icons.star), title: Text('10000000명이 좋아합니다', style: TextStyle(fontFamily: 'cafe24')))
        ]
      ),
    );
  }
}
