import 'package:flutter/material.dart';

class Example1Page extends StatefulWidget {
  const Example1Page({Key? key}) : super(key: key);

  @override
  State<Example1Page> createState() => _Example1PageState();
}

class _Example1PageState extends State<Example1Page> {
  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example1'),
        ),
        body: Column(
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
                child: Center(
                  child: Icon(
                    Icons.account_circle,
                    size: imageSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('사진찍기'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('라이브러리에서 불러오기'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}