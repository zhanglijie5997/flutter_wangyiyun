import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Components/Listen.dart';
import 'package:wangyiyun/Components/Toast.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Utils/Fluro/Fluro.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {

  List<Map<String, String>> _tabs = [
    { "name": "我的消息", "image": 'images/email.png', "path": '' },
    { "name": "我的好友", "image": 'images/friends.png', "path": '' },
    { "name": "个人主页", "image": 'images/home.png', "path": '' },
    { "name": "个性装扮", "image": 'images/shirt.png', "path": '' },
  ];

  Map<String, dynamic> _musicList = {
    "title": "音乐服务",
    "list": [
      { "images": "images/tickets.png", "name": "演出" },
      { "images": "images/shop.png", "name": "商城" },
      { "images": "images/wallet.png", "name": "在线听歌免流量" },
    ]
  };
  Map<String, dynamic> _tool = {
    "title": "小工具",
    "list": [
      { "images": "images/setting.png", "name": "设置" },
      { "images": "images/night.png", "name": "夜间模式", "swich": true },
      { "images": "images/timing.png", "name": "定时关闭" },
      { "images": "images/stop.png", "name": "音乐黑名单" },
      { "images": "images/wallet.png", "name": "鲸云音效" },
      { "images": "images/wallet.png", "name": "添加Siri路径" },
      { "images": "images/clock.png", "name": "音乐闹钟" },
      { "images": "images/security.png", "name": "青少年模式" },
    ]
  };

  bool _signStatus = false; // 签到状态

  String _signText = '签到'; // 签到文字

  Color _signColor = Colors.red; // 签到颜色

  // 顶部
  Widget title() {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Image.asset("images/scan.png"),
            onTap: () async {
              // Toast().showText("扫一扫");
              Application.router.navigateTo(context, '/scan');
            },
          ),
          Container(
            child: Listen(),
          )
        ]);
  }

  // 开通会员
  Widget body() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(160, 158, 159, 0.9), 
                             Color.fromRGBO(140, 138, 139, 0.9),
                             Color.fromRGBO(120, 120, 120, 0.9)],
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Flex(
                    verticalDirection: VerticalDirection.down,
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.only(top:10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("开通黑胶VIP", style: TextStyle(
                                color: Color.fromRGBO(243, 225, 225, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ))
                            ),
                            Container(
                              child: Text("立享超12项特权", style: TextStyle(
                                color: Color.fromRGBO(194, 192, 193, 1)
                              )),
                            )
                            
                          ],
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 24,
                        child: Center(
                          child: Text("立即开通", style: TextStyle(
                            color: Color.fromRGBO(143, 137, 141, 1)
                          )),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(247, 226, 221, 1), Color.fromRGBO(210, 185, 178, 1)]
                          )
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Container(
                height: 65,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(160, 158, 159, 1), Color.fromRGBO(120, 120, 120, 1)],
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top:10),
                  child: Flex(direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          margin: EdgeInsets.all(0),
                          child: Text("会员中心",style: TextStyle(
                            color: Color.fromRGBO(236, 219, 217, 1),
                            fontSize: 17
                          )),
                        ),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 4),
                          child: Text("畅享超12项豪华特权", style: TextStyle(
                                color: Color.fromRGBO(194, 192, 193, 1)
                              )),
                        ),
                      ],
                    ),
                    // Text("data")
                    Image.asset("images/right.png", width: 16, height: 16,)
                  ]),
                ) ,
              ),
              
            ],
          ),
        )
      ],
    );
  }

  // 用户信息
  Widget user(Color color) {
    List<Widget> _list = [];
    for(int i = 0; i < this._tabs.length; i++) {
      _list.add(
        Expanded(
          flex: 1,
          child: Container(
            width: 50,
            child:  GestureDetector(
              onTap: () {

              },
              child: Column(
                children: <Widget>[
                  Image.asset(this._tabs[i]['image'], width: 25, height: 25),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.only(top: 10),
                    child: Text(this._tabs[i]['name'], style: TextStyle(
                      color: Colors.white,
                    )),
                  )
                ],
              ),
            )
          )
        )
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    child: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(image: NetworkImage("https://p1.music.126.net/pPQUoss_URHaG02bne4xJw==/19082024300141092.jpg?param=30y30"), fit: BoxFit.cover) 
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("IM痞", style: TextStyle(
                      color: Colors.white
                    ))
                  )
                  
                ],
              ),
              GestureDetector(
                onTap: () {
                  if(this._signStatus) {
                    return;
                  }
                  Toast().showText("签到成功");
                  this.setState(() { 
                    _signText = !this._signStatus ? '已签到' : '签到';
                    _signStatus = !this._signStatus;
                    _signColor = Color.fromRGBO(153, 153, 153, 1);
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: this._signColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 16,
                          height: 16,
                          child: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(image: AssetImage('images/sign.png'), fit: BoxFit.cover) 
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(this._signText, style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                          ))
                        )
                      ],
                    ),
                ),
              )
            ]),
          ),
          // 消息 好友 个人主页 个性装扮
              Container(
                width: MediaQuery.of(context).size.width,
                child: Flex(direction: Axis.horizontal, children: _list)
              )
        ],
      ),
    );
  }
  
  // 创作者中心
  Widget creator(Color _color) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10),
      height: 45,
      color: _color,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/bulb.png', width: 24, height: 24,),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("创作者中心", style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                          )),
                        ) 
                      ],
                    ),
                  ),
                  Image.asset('images/right.png', width: 16, height: 16,)
                ]
              )
            ) 
    );
  }

  Widget publicTitle(Color _color, String _title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: _color,
        border: Border(bottom: BorderSide(
          color: Color.fromRGBO(41, 41, 41, 1),
          width: 1
        ))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(_title, style: TextStyle(
          color: Colors.white
        )),
      ) ,
    );
  }

  Widget publicList(String _image, String _name) {
    return GestureDetector(
      onTap: () {
        Toast().showText("功能暂未开通");
      },
      child:  Container(
        padding: EdgeInsets.only(left: 15),
          child: Flex(direction: Axis.horizontal, children: <Widget>[
            Image.asset(_image, width: 20, height: 20,),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Color.fromRGBO(41, 41, 41, 1),
                    width: 1 
                  ))
                ),
                child: Container(
                  height: 45,
                  child: Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Text(_name, style: TextStyle(
                      color: Colors.white
                    )),
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Image.asset("images/right.png", width: 16, height: 16),
                    )
                  ]),
                ) 
              )
            )
          ]
        ),
      )
    ); 
  }

  // 音乐服务
  Widget musicService(Color _color, Map<String, dynamic> _map) {
    List<Widget> _list = [];
    for(int i = 0 ; i < _map['list'].length; i++) {
      _list.add(
        publicList(_map['list'][i]['images'], _map['list'][i]['name'])
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      color: _color,
      child: Container(
        child: Column(
          children: <Widget>[
            // 顶部
            publicTitle(_color, _map['title']),
            Column(
              children: _list,
            )
          ],
        ),
      ) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, state, child) {
      return ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50),
                  // width: MediaQuery.of(context).size.width * 0.95,
                  // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                  child: SingleChildScrollView(
                    primary: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          
                          body(),
                          user(state.color),
                          creator(state.color),
                          musicService(state.color, this._musicList),
                          musicService(state.color, this._tool)
                        ],
                      ),
                    ) ,
                  )
              ),
              Positioned(
                // 头部扫一扫
                child: Container(
                  color: state.color,
                  width: MediaQuery.of(context).size.width ,
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, top: 50),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    child: title(),
                  )  ,
                ),)
            ],
          )  
      );
    });
  }
}
