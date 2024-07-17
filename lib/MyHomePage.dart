import 'package:flutter/material.dart';
import 'add_post_page.dart';
import 'transition_route_state.dart';
import 'next_page.dart';
import 'radial_expansion_route.dart';

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
            actions:[
              IconButton(onPressed: () {
                Navigator.of(context).push(
                  TransitionRouteState(
                    page: const AddPostPage(),
                    transition: radialExpansionRoute,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
                  icon: Image.asset('assets/images/plus.png')),
              IconButton(onPressed: () {
                Navigator.of(context).push(
                  TransitionRouteState(
                    page: const TargetPage(),
                    transition: radialExpansionRoute,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
                  icon: Image.asset('assets/images/profile.png')),
            ]
        ),
        body: Container(
          child: SingleChildScrollView(
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
