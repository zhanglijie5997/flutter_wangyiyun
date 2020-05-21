import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';

class Listen extends StatefulWidget {
  Listen({Key key}) : super(key: key);

  @override
  _ListenState createState() => _ListenState();
}

class _ListenState extends State<Listen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, state, child) {
      return Container(
        width: 30,
        height: 30,
        child: null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage("https://p2.music.126.net/D-mpVLLwMrA-hPu0QPYUNQ==/109951163551410648.jpg?param=34y34"), 
            fit: BoxFit.fill
          )
        ),
      );
    });
  }
}