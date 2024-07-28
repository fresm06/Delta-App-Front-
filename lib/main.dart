import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        ],
        leading: Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Delta_image.png'),
            ),
          ),
        ),
        title: const Text('Delta', style: TextStyle(fontFamily: 'moya')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text('ID: 사용자', style: TextStyle(fontSize: 20)),
                Text('e-mail', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            child: const Example1Page(),
          ),
          const SizedBox(height: 8), // Adding a small gap between Example1Page and MyWidget
          Expanded(child: MyWidget()),
        ],
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.transparent,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.book),
            title: const Text('가장 잘하는 과목'),
            iconColor: Colors.brown,
            children: <Widget>[
              ListTile(
                title: const Text('수학'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('과학'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.language),
            title: const Text('언어'),
            iconColor: Colors.blue,
            children: <Widget>[
              ListTile(
                title: const Text('영어'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('한국어'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.person_2_outlined),
            title: const Text('프로필 관리'),
            children: <Widget>[
              ListTile(
                title: const Text('개인 정보 수정'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('비밀번호 변경'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
            children: <Widget>[
              ListTile(
                title: const Text('일반'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('알림'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.alarm),
            title: const Text('알림'),
            trailing: const SwitchExample(),
            iconColor: Colors.deepOrange,
                onTap: () {},
              ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 100,
            height: 50,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            child: Text('로그아웃',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class Example1Page extends StatefulWidget {
  const Example1Page({Key? key}) : super(key: key);

  @override
  State<Example1Page> createState() => _Example1PageState();
}

class _Example1PageState extends State<Example1Page> {
  @override
  Widget build(BuildContext context) {
    final double _imageSize = MediaQuery.of(context).size.width / 4;

    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: _imageSize,
              minWidth: _imageSize,
            ),
            child: GestureDetector(
              onTap: () {
                _showBottomSheet();
              },
              child: const Center(
                child: Icon(
                  Icons.account_circle,
                  size: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('사진찍기'),
            ),
            SizedBox(height: 10),
            const Divider(
              thickness: 3,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('사진첩에서 불러오기'),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
