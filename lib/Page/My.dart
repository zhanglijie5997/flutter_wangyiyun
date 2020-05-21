import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
class My extends StatefulWidget {
  My({Key key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, counterState, child) {
      return Scaffold(
        backgroundColor: counterState.color,
        body: Text("我的")
      );
    }) ;
  }
}