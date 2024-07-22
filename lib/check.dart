import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart'; // MyHomePage를 import

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  Timer? _timer;
  int _seconds = 0;
  final List<String> _studyRecords = [
    "07/16/2023 - 2 hours",
    "07/17/2023 - 1.5 hours",
    "07/18/2023 - 3 hours",
    "07/19/2023 - 2.5 hours",
    // Add more dummy records here
  ];

  @override
  void initState() {
    super.initState();
    _startTimer(); // 페이지가 로드될 때 타이머 시작
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
      _startTimer(); // 타이머 리셋 후 다시 시작
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: const Text("공부 시간 측정"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_seconds),
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text(
                    "정지",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 40), // Add space between buttons and study records
            const Text(
              "공부 기록",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _studyRecords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _studyRecords[index],
                      style: const TextStyle(color: Colors.white), // 텍스트 색상을 흰색으로 설정
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
