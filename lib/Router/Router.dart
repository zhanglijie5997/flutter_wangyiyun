
import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Components/Toast.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Page/Index.dart';
import 'package:wangyiyun/Page/My.dart';
import 'package:wangyiyun/Page/Setting.dart';
import 'package:wangyiyun/Page/Video.dart';
import 'package:wangyiyun/Page/Yum.dart';

class Router extends StatefulWidget {
  Router({Key key}) : super(key: key);

  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  int _number = 2;
  int _currentIndex = 0;

  List<Widget> _routes = [ Index(), Video(), My(), Yum(), Setting()];
  
  void _getLoc(BuildContext context) async{
    await AMapLocationClient.startup(new AMapLocationOption(
      desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
    var location = await AMapLocationClient.getLocation(true);
    print("""
      经度：${location.longitude}
      纬度：${location.latitude}
      """);
      Map<String, double> _loc = {
        "lng": location.longitude,
        "lat": location.latitude
      };
      if(location != null) {
        Toast().showText("获取地理位置成功");
        Provider.of<CounterState>(context, listen: false).updateLocal(_loc);
      }
      
    }


  Widget getRoute () {
    switch (_currentIndex) {
      case 0:
        return Index();
      case 1:
        return Video();
      case 2:
        return My();
      case 3:
        return Yum();
      case 4:
        return Setting();
      default:
        return Index();
    }
  }
  @override
  void initState() {
    super.initState();
    this._getLoc(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(34, 35, 36, 1),
        resizeToAvoidBottomPadding: false,
        body: IndexedStack(
          index: _currentIndex,
          children: _routes,
        ) ,
        
        bottomNavigationBar: BottomNavigationBar(
         selectedItemColor: Colors.red,
         currentIndex: _currentIndex,
         backgroundColor: Color.fromRGBO(35, 36, 37, 1),
         onTap: (int index) {
           this.setState(() { 
             _currentIndex = index;
           });
         },
         unselectedItemColor: Colors.white,
         type: BottomNavigationBarType.fixed,
         items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: 
                   Icon(Icons.music_note, color: Colors.white, size: 20,), 
                        activeIcon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(Icons.music_note, color: Colors.white, size: 20,)), title: Text("首页"), 
                        ),
                  BottomNavigationBarItem(icon: Icon(Icons.personal_video, color: Colors.white,size: 20,), 
                    activeIcon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(Icons.personal_video, color: Colors.white, size: 20)), title: Text("视频")),
                  BottomNavigationBarItem(icon: Icon(Icons.menu, color: Colors.white,size: 20,), 
                    activeIcon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(Icons.menu, color: Colors.white,)), title: Text("我的")),
                  BottomNavigationBarItem(icon: Icon(Icons.people_outline, color: Colors.white,size: 20,), 
                    activeIcon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(Icons.people_outline, color: Colors.white, size: 20)), title: Text("云村")),
                  BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.white,size: 20,), 
                    activeIcon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(Icons.settings, color: Colors.white, size: 20)), title: Text("我的")),
                ]
       )
      //  Consumer<CounterState>(builder: (BuildContext context, counterState, child) {
      //    return Center(
      //      child: RaisedButton(
      //        color: Colors.red,
      //        onPressed: () {
      //          Provider.of<CounterState>(context, listen: false).update(_number);
      //          this.setState(() {
      //            _number =  _number + 1;
      //          });
      //        },
      //       child: Text(counterState.counter.toString() ),) ,
      //    );
      //  })  
    );
  }
}