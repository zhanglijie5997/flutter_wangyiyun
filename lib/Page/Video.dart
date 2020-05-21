import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, counterState, child) {
      return Scaffold(
        backgroundColor: counterState.color,
        body: Text("Video"),
      );
    });
  }
}