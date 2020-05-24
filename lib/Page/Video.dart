import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Components/Title.dart';
import 'package:wangyiyun/Components/Video/Video.dart';
import 'package:wangyiyun/Components/Video/VideoCom.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Utils/HttpList/VideoHttp.dart';

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> with TickerProviderStateMixin{

  GlobalKey globalKey = GlobalKey();

  List<dynamic> _horComList = [];

  int currentId = 0; // 音乐id

  int current = 0; // 横向索引

  double scroll = 0; // 滚动距离

  ScrollController _controller = ScrollController();

  List<dynamic> _list = [];
  // 修改索引
  void changeCurrent(int i, int id) {
    this.setState(() {
      current = i;
      currentId = id;
    });
  }

  // 设置滚动距离
  void changeScroll( double _scroll) {
    this.setState(() {
      scroll = _scroll;
    });
    double _width = MediaQuery.of(context).size.width / 4;
    // print(_width);
    print(_scroll);
    if(_width > _scroll) {
      // print("进入");
      // print(this._controller);
      // this._controller.jumpTo(_scroll);
    }
  }

  Widget horCom(Color _color) {
    List<Widget> _list = [];
    for(int i = 0; i < this._horComList.length; i++) {
      _list.add(
        VideoItem(active: this.current == i, 
                  color: _color, item: this._horComList[i], 
                  changeCurrent: this.changeCurrent,index: i,
                  changeScroll: this.changeScroll, id: this._horComList[i]['id'])
      );
    }
    return Container(
            height: 30,
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              indicatorColor: Colors.red,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _list, 
              controller: TabController(length: this._horComList.length, vsync: this, initialIndex: this.current),
            )
              // controller: TabController(length: this._horComList.length, ),)
            //  SingleChildScrollView(
            //   controller: _controller,
            //   scrollDirection: Axis.horizontal,
            //   primary: false,
            //   physics: BouncingScrollPhysics(),
            //   padding: EdgeInsets.only(left: 10),
            //   child: Row(
            //     children: _list
            //   ),
            // )
          );
  }

  Future getPersonalizedMv() async {
    var data =  await VideoHttp.personalizedMv();
    this.setState(() {
      _list = data['result'];
    });
    // print(data);
  }

  Future getVideoGroupList() async{
    var data = await VideoHttp.videoGroupList();
    this.setState(() {
      _horComList = data['data'];
      currentId = data['data'][0]['id'];
      this.getPersonalizedMv();
    });
  }

  @override
  void initState() {
    this.getVideoGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, state, child) {
      return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child:  Stack(
          children: <Widget>[
            Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
              padding: EdgeInsets.only(top: 130),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: true,
                // padding: EdgeInsets.only(top: 10),
                physics: BouncingScrollPhysics(),
                itemCount: this._list.length,
                itemBuilder: (context, i) {
                  return VideoCom(item: this._list[i]);
                })
            ),

            Positioned(
              height: 90,
              top: 50,
              child: Container(
                color: state.color,
                // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03),
                child: Column(
                  children: <Widget>[
                    Nav(),
                    horCom(state.color)
                  ],
                ) ,
              ) 
            ),
            
          ],
        ) ,
      ) ;
    });
  }
}