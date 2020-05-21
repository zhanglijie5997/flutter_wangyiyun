import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
class Rank extends StatefulWidget {
  Rank({Key key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (BuildContext context, state, child) {
      return Scaffold(
        backgroundColor: state.color,
        appBar: AppBar(
          backgroundColor: state.color,
          title: Text("排行榜"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          primary: false,
          child: Container(
            child: Column(
              children: <Widget>[
                Text("data"),
                Text("data"),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("返回"),
                )
              ],
            ),
          ),
        ) 
      );
    });
  }
}