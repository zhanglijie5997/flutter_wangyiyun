import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 上啦刷新 下啦加载组件
class Refresh extends StatefulWidget {
  final Widget widget;
  Refresh({Key key, this.widget}) : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  RefreshController _refreshController = RefreshController(initialRefresh: true );
  
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      dragStartBehavior: DragStartBehavior.down,
      header: TwoLevelHeader(
        // height: 100,
        refreshingText: "刷新中",
        completeText: "刷新成功",
        idleText: "放开刷新",
        releaseText: "释放刷新",
        textStyle: TextStyle(color: Colors.white),
        displayAlignment: TwoLevelDisplayAlignment.fromTop,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage("images/index.jpeg"),
            //     fit: BoxFit.cover,
            //     // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
            //     alignment: Alignment.topCenter
            // ),
            // color: Colors.red
            ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          print(mode);
          print("----");
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
            body = Container(
              width: MediaQuery.of(context).size.width,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("加载中...",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("松手,加载更多!");
          } else {
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: this.widget.widget,
    );
  }
}
