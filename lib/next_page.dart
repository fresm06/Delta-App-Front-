import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class TargetPage extends StatefulWidget {
  const TargetPage({super.key});

  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();
  List<String> subjects = ['과목1', '과목2', '과목3'];
  List<RadarEntry> dataEntries = [RadarEntry(value: 0), RadarEntry(value: 0), RadarEntry(value: 0)];
  List<int> studyTimes = [0, 0, 0];
  List<Color> subjectColors = [Colors.blue, Colors.green, Colors.red];
  Timer? _timer;
  bool isStudying = false;
  int currentSubjectIndex = -1;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subjects = prefs.getStringList('subjects') ?? subjects;
      studyTimes = prefs.getStringList('studyTimes')?.map((e) => int.parse(e)).toList() ?? studyTimes;
      dataEntries = studyTimes.map((time) => RadarEntry(value: time.toDouble())).toList();
      subjectColors = prefs.getStringList('subjectColors')?.map((e) => Color(int.parse(e))).toList() ?? subjectColors;
    });
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('subjects', subjects);
    await prefs.setStringList('studyTimes', studyTimes.map((e) => e.toString()).toList());
    await prefs.setStringList('subjectColors', subjectColors.map((e) => e.value.toString()).toList());
  }

  void addCategory(String subject) {
    setState(() {
      subjects.add(subject);
      dataEntries.add(RadarEntry(value: 0));
      studyTimes.add(0);
      subjectColors.add(Colors.blue); // 기본 색상 추가
      _saveData();
    });
  }

  void updateCategory(int index, String newSubject, Color newColor) {
    setState(() {
      subjects[index] = newSubject;
      subjectColors[index] = newColor;
      _saveData();
    });
  }

  void deleteCategory(int index) {
    if (subjects.length > 3) {
      setState(() {
        subjects.removeAt(index);
        dataEntries.removeAt(index);
        studyTimes.removeAt(index);
        subjectColors.removeAt(index);
        _saveData();
      });
    }
  }

  void startStudyMode(int index) {
    if (isStudying) {
      stopStudyMode();
    }

    setState(() {
      isStudying = true;
      currentSubjectIndex = index;
      elapsedTime = studyTimes[index];
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime++;
        studyTimes[index] = elapsedTime;
        dataEntries[index] = RadarEntry(value: elapsedTime.toDouble());
        _saveData();
      });
    });
  }

  void stopStudyMode() {
    _timer?.cancel();
    setState(() {
      isStudying = false;
      currentSubjectIndex = -1;
    });
  }

  int getTotalStudyTime() {
    return studyTimes.fold(0, (sum, item) => sum + item);
  }

  void _showEditDialog(int index) {
    _editController.text = subjects[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('과목 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editController,
                decoration: InputDecoration(labelText: '새로운 과목 이름'),
              ),
              SizedBox(height: 20),
              Text('과목 색상 선택'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Colors.primaries.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          subjectColors[index] = color;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 30,
                        height: 30,
                        color: color,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_editController.text.isNotEmpty) {
                  updateCategory(index, _editController.text, subjectColors[index]);
                  Navigator.of(context).pop();
                }
              },
              child: Text('수정'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalStudyTime = getTotalStudyTime();

    return Scaffold(
      appBar: AppBar(
        title: Text('총 공부 그래프'),
      ),
      body: Column(
        children: [
          // 과목 추가 UI
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: '과목 추가',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    addCategory(_controller.text);
                    _controller.clear();
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: RadarChart(
                      RadarChartData(
                        dataSets: [
                          RadarDataSet(
                            dataEntries: dataEntries,
                            fillColor: Colors.blue.withOpacity(0.3),
                            borderColor: Colors.blue,
                            entryRadius: 2,
                            borderWidth: 2,
                          ),
                        ],
                        radarBackgroundColor: Colors.transparent,
                        tickCount: 5,
                        ticksTextStyle: TextStyle(color: Colors.grey, fontSize: 10),
                        tickBorderData: BorderSide(color: Colors.grey),
                        gridBorderData: BorderSide(color: Colors.grey),
                        getTitle: (index, angle) {
                          return RadarChartTitle
                            (text: subjects.isNotEmpty ? subjects[index] : '',
                          angle: angle,

                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${subjects[index]}: ${studyTimes[index]}초',
                            style: TextStyle(color: subjectColors[index], fontWeight: FontWeight.bold)),
                        onTap: () {
                          startStudyMode(index);
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                _showEditDialog(index);
                              },
                            ),
                            if (subjects.length > 3)
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteCategory(index);
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 총 공부 시간 표시
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '총 공부 시간: ${totalStudyTime}초',
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Stop button for study mode
          if (isStudying)
            ElevatedButton(
              onPressed: stopStudyMode,
              child: Text('공부 모드 종료'),
            ),
        ],
      ),
    );
  }
}
