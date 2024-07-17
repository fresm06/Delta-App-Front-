import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _image;
  String? _location;
  List<String> _tags = [];
  String _visibility = '모두에게 공개';
  final TextEditingController _textController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addLocation() async {
    String? location = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        String tempLocation = '';
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: '위치를 입력하세요'),
                onChanged: (value) {
                  tempLocation = value;
                },
              ),
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context, tempLocation);
                },
              ),
            ],
          ),
        );
      },
    );

    if (location != null) {
      setState(() {
        _location = location;
      });
    }
  }

  void _tagPeople() async {
    List<String>? tags = await showModalBottomSheet<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> tempTags = [];
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: '사람을 태그하세요 (쉼표로 구분)'),
                onChanged: (value) {
                  tempTags = value.split(',').map((e) => e.trim()).toList();
                },
              ),
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context, tempTags);
                },
              ),
            ],
          ),
        );
      },
    );

    if (tags != null) {
      setState(() {
        _tags = tags;
      });
    }
  }

  void _selectVisibility() async {
    String? visibility = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('모두에게 공개'),
                onTap: () {
                  Navigator.pop(context, '모두에게 공개');
                },
              ),
              ListTile(
                title: Text('팔로워에게만 공개'),
                onTap: () {
                  Navigator.pop(context, '팔로워에게만 공개');
                },
              ),
              ListTile(
                title: Text('비공개'),
                onTap: () {
                  Navigator.pop(context, '비공개');
                },
              ),
            ],
          ),
        );
      },
    );

    if (visibility != null) {
      setState(() {
        _visibility = visibility;
      });
    }
  }

  void _submitPost() {
    // 여기에 게시물을 처리하는 로직을 추가할 수 있습니다.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '새 게시물',
          style: TextStyle(fontFamily: 'cafe24', fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: _submitPost,
            child: Text(
              '게시하기',
              style: TextStyle(color: Colors.white, fontFamily: 'cafe24'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '문구를 작성하세요...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              _image == null
                  ? TextButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                label: Text('사진 추가', style: TextStyle(fontFamily: 'cafe24')),
                onPressed: _pickImage,
              )
                  : Image.file(_image!),
              SizedBox(height: 10),
              _location == null
                  ? TextButton.icon(
                icon: Icon(Icons.location_on),
                label: Text('위치 추가', style: TextStyle(fontFamily: 'cafe24')),
                onPressed: _addLocation,
              )
                  : ListTile(
                leading: Icon(Icons.location_on),
                title: Text(_location!, style: TextStyle(fontFamily: 'cafe24')),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _addLocation,
                ),
              ),
              SizedBox(height: 10),
              _tags.isEmpty
                  ? TextButton.icon(
                icon: Icon(Icons.person_add),
                label: Text('사람 태그', style: TextStyle(fontFamily: 'cafe24')),
                onPressed: _tagPeople,
              )
                  : Column(
                children: [
                  for (String tag in _tags)
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(tag, style: TextStyle(fontFamily: 'cafe24')),
                    ),
                  TextButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('사람 태그 수정', style: TextStyle(fontFamily: 'cafe24')),
                    onPressed: _tagPeople,
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.public),
                title: Text(_visibility, style: TextStyle(fontFamily: 'cafe24')),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _selectVisibility,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('게시하기', style: TextStyle(fontFamily: 'cafe24')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
