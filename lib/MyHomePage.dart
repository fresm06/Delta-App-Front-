import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Delta',
          style: TextStyle(
            fontFamily: 'cafe24',
            fontSize: 40,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // 휴대폰 버전
            return MobileLayout();
          } else {
            // 컴퓨터 버전
            return DesktopLayout();
          }
        },
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 2.0,
            color: Colors.black12,
          ),
          Film(isWide: false),
          Film(isWide: false),
          Film(isWide: false),
          Film(isWide: false),
          Film(isWide: false),
        ],
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 2.0,
            color: Colors.black12,
          ),
          Film(isWide: true),
          Film(isWide: true),
          Film(isWide: true),
          Film(isWide: true),
          Film(isWide: true),
        ],
      ),
    );
  }
}

class Film extends StatefulWidget {
  final bool isWide;

  const Film({Key? key, required this.isWide}) : super(key: key);

  @override
  _FilmState createState() => _FilmState();
}

class _FilmState extends State<Film> {
  bool isStarYellow = false;

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CommentsScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageWidth = widget.isWide ? constraints.maxWidth * 0.5 : MediaQuery.of(context).size.width;
        double starSize = widget.isWide ? 50 : 30;
        double textScaleFactor = widget.isWide ? 1.5 : 1.0;

        return SizedBox(
          width: widget.isWide ? double.infinity : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 5, 5),
                child: PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: AppBar(
                    scrolledUnderElevation: 0,
                    leading: Image.asset('assets/images/testprofile.png', width: 10, height: 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('집사', style: TextStyle(fontFamily: 'KB', fontSize: 25, fontWeight: FontWeight.bold)),
                        Text('총 공부시간: 100시간', style: TextStyle(fontFamily: 'KB', fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
              widget.isWide
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/mrfresh.jpg', width: imageWidth),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 160),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isStarYellow = !isStarYellow;
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: isStarYellow
                                ? Image.asset('assets/images/yellow star.png', width: starSize, height: starSize, key: ValueKey('yellow'))
                                : Image.asset('assets/images/bstar.png', width: starSize, height: starSize, key: ValueKey('grey')),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _showComments(context);
                          },
                          child: Image.asset('assets/images/chating.png', width: starSize, height: starSize),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset('assets/images/mrfresh.jpg', width: imageWidth),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isStarYellow = !isStarYellow;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                                return ScaleTransition(scale: animation, child: child);
                              },
                              child: isStarYellow
                                  ? Image.asset('assets/images/yellow star.png', width: starSize, height: starSize, key: ValueKey('yellow'))
                                  : Image.asset('assets/images/bstar.png', width: starSize, height: starSize, key: ValueKey('grey')),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _showComments(context);
                            },
                            child: Image.asset('assets/images/chating.png', width: starSize, height: starSize),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10), // 텍스트와 이미지 사이에 공백 없애기
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 텍스트가 왼쪽 정렬되도록 설정
                  children: [
                    Text(
                      '귀여운 고양이',
                      style: TextStyle(
                        fontFamily: 'KB',
                        fontSize: 25 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '#귀여운 #고양이 #열공',
                      style: TextStyle(
                        fontFamily: 'KB',
                        fontSize: 15 * textScaleFactor,
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final List<String> _comments = [];
  final TextEditingController _controller = TextEditingController();

  void _addComment() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _comments.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('댓글'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('사용자${index + 1}'),
                  subtitle: Text(_comments[index]),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
