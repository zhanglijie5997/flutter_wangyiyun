
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Utils/UrlLauncher/urlLauncher.dart';
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
        appBar: AppBar(
          title: Text("我的"),
        ),
        backgroundColor: counterState.color,
        body:  IconButton(onPressed: () async{
          bool result = await UrlLauncher.openBrow('https://www.baidu.com');
        }, icon: Icon(Icons.add), color: Colors.red,)
      );
    }) ;
  }
}