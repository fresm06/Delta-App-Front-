import 'package:flutter/material.dart';
import 'transition_route_state.dart';
import 'next_page.dart';
import 'radial_expansion_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _opacity = 1 - (_scrollController.offset / 300).clamp(0, 1);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delta',
          style: TextStyle(
            fontFamily: 'cafe24',
            fontSize: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                TransitionRouteState(
                  page: const TargetPage(),
                  transition: radialExpansionRoute,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: Image.asset('assets/images/profile.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: const [
            Text(
              '대충 오늘 공부시간 1등',
              style: TextStyle(
                fontFamily: 'cafe24',
                fontSize: 20,
              ),
            ),
            film(),
            film(),
            film(),
            film(),
            film(),
            film(),
            film(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow.withOpacity(_opacity),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'study',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          // 버튼이 눌렸을 때의 동작 정의
          // 현재는 아무 동작도 하지 않음
        },
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
          AppBar(
            leading: Image.asset('assets/images/testprofile.png', width: 10, height: 10),
            title: const Text('귀여운 고양이', style: TextStyle(fontFamily: 'cafe24')),
          ),
          Image.asset('assets/images/mrfresh.jpg'),
          AppBar(
            leading: const Icon(Icons.star),
            title: const Text('10000000명이 좋아합니다', style: TextStyle(fontFamily: 'cafe24')),
          ),
        ],
      ),
    );
  }
}

class TransitionRouteState extends PageRouteBuilder {
  final Widget page;
  final Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transition;
  final Duration duration;

  TransitionRouteState({
    required this.page,
    required this.transition,
    required this.duration,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => transition(context, animation, secondaryAnimation, child),
    transitionDuration: duration,
  );
}

Widget radialExpansionRoute(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}
