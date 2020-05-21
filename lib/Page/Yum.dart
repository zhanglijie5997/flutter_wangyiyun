import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';

class Yum extends StatefulWidget {
  Yum({Key key}) : super(key: key);

  @override
  _YumState createState() => _YumState();
}

class _YumState extends State<Yum> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: state.color,
        body: Text('云村'),
      );
    }); 
  }
}