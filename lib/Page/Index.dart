import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wangyiyun/Components/Listen.dart';
import 'package:wangyiyun/Components/Refresh.dart';
import 'package:wangyiyun/Components/Swiper.dart';
import 'package:wangyiyun/Components/Title.dart';
import 'package:wangyiyun/Components/Toast.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Mobx/IndexState.dart';
import 'package:wangyiyun/Utils/Fluro/Fluro.dart';
import 'package:wangyiyun/Utils/HttpList/IndexHttp.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  ScrollController _controller = ScrollController();

  RefreshController _refreshController = RefreshController(initialRefresh: true, initialLoadStatus: LoadStatus.loading );

  List<dynamic> _list = [];

  List<dynamic> _horComList = [
    {"name": "每日推荐", "id": 0, "path": "/rank"},
    {"name": "歌单", "id": 1, "path": "/rank"},
    {"name": "排行榜", "id": 2, "path": "/rank"},
    {"name": "电台", "id": 3, "path": "/rank"},
    {"name": "直播", "id": 4, "path": "/rank"},
    {"name": "唱聊", "id": 5, "path": "/rank"}
  ];

  List<dynamic> _purpleList = [];

  List<dynamic> _personalizedNewSong = []; // 推荐歌单

 

  void showLongToast() {
    Toast().showText("测试");
  }

  // 横向列表
  Widget horCom() {
    List<Widget> viewList = [];

    for (var i = 0; i < _horComList.length; i++) {
      viewList.add(
        GestureDetector(
            onTap: () {
              Application.router.navigateTo(context, "/rank");
            },
            child: Container(
                width: 80,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 20, top: 10, left: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              color: Color.fromRGBO(44, 45, 46, 1),
                              child: Center(
                                child: Icon(Icons.monetization_on),
                              )),
                        )),
                    Container(
                      width: 80,
                      // color: Colors.red,
                      // color: Colors.blue,
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Center(
                        child: Text(
                          _horComList[i]["name"],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    )
                  ],
                )))),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: viewList,
      ),
    );
  }

  // 人气歌单推荐
  Widget purple(String title, bool status, List list) {
    List<Widget> _list = [];
    for (int i = 0; i < list.length; i++) {
      _list.add(
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 160,
          width: 130,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _purpleList[i]['picUrl'] != null? NetworkImage(_purpleList[i]['picUrl']) : AssetImage("images/placeholder.png") )),
                child: Container(
                    width: 110,
                    margin: EdgeInsets.only(right: 5, top: 5),
                    child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      direction: Axis.horizontal,
                      children: <Widget>[
                         Image.network(
                          "https://static.ilaisa.com/static/images/ls_shop/shouyegengduo_10.22@3x.png",
                          width: 15,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: list[i]['trackNumberUpdateTime'] != null
                              ? Text(
                                  list[i]['playCount'] > 10000
                                      ? (list[i]['playCount'] / 10000)
                                              .toString() +
                                          '万'
                                      : list[i]['playCount'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              : null,
                        )
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(list[i]['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color.fromRGBO(190, 191, 192, 1))),
              )
            ],
          ),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                    child: Text(title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)))),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: GestureDetector(
                  onTap: showLongToast,
                  child: Container(
                    // padding: EdgeInsets.all(10),
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        // color: Colors.red,
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(74, 75, 76, 1))),
                    child: Center(
                      child: Text(
                        '查看更多',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )),
            )
          ],
        ),
        // 列表
        Container(
          height: 190,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: _list,
          ),
        )
      ],
    );
  }

  Future getIndex() async {
    var res = await IndexHttp().personalized();
    // var topPlaylistHighquality = await IndexHttp().topPlaylistHighquality();
    var banner = await IndexHttp().banner();
    this.setState(() {
      _purpleList = res['result'];
      
    });
    if(banner is bool || res is bool) {
      getIndex();
    }
    this.setState(() {
      _list = banner['banners'];
     });
  }

  // 获取推荐歌单
  Future getPersonalizedNewsong() async {
    var data = await IndexHttp().personalizedNewsong();
    this.setState(() {
      _personalizedNewSong = data['result'];
    });
  }

 
  void update(BuildContext context) {
    Provider.of<IndexState>(context, listen: false)
        .updateOffset(_controller.offset);
  }

  
  @override
  void initState() {
    this.getIndex();
    this.getPersonalizedNewsong();
    
    super.initState();
  }
 
  @override
  void dispose() {
    super.dispose();
    BotToast.cleanAll();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(
          builder: (BuildContext context, state, child) {
            return ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100),
                      child: Refresh(
                        addList: () async {
                          print('上啦加载');
                          
                        },
                        widget: SingleChildScrollView(
                        // key: UniqueKey(),
                        controller: _controller,
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            // 轮播
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: this._list.length > 0
                                    ? SwiperCom(list: this._list)
                                    : null),
                            // 横向列表
                            Container(
                              child: horCom()
                            ),
                            // 人气歌单
                            Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.02,
                                    top: 10),
                                child: purple("人气歌单推荐", false, this._purpleList)),
                            // 温柔岁月的华语情怀
                            Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.02,
                                    top: 10),
                                child: purple("温柔岁月的华语情怀 ", true, this._purpleList)),
                            FlatButton(
                                onPressed: () {
                                  print('object---');
                                },
                                child: Icon(Icons.arrow_downward))
                          ],
                        ),
                      ),
                      ),
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width ,
                      // padding: EdgeInsets.only(left:  MediaQuery.of(context).size.width * 0.03, right:  MediaQuery.of(context).size.width * 0.03),
                      color: state.color,
                      child:Nav(),
                    ) ,
                  )
                ],
              ),
            );
          },
        );
  }
}
