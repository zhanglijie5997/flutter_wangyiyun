import 'dart:convert';

import 'package:wangyiyun/Utils/Http/Http.dart';

abstract class AlbumNewestType{
  int code;
}

class IndexHttp  {
  Future albumNewest() async{
    var res = await Http().dioGet('/album/newest');
    if(!(res is bool)) {
      return res;
    }
  }

  // 推荐新音乐
  Future personalizedNewsong() async {
    var res = await Http().dioGet('/personalized/newsong');
    if(!(res is bool)) {
      return res;
    }
  }
  // 推荐歌单
  Future personalized() async{
    var res = await Http().dioGet("/personalized?limit=10");
    if(!(res is bool)) {
      return res;
    }
  }
  // 获取精品歌单
  Future topPlaylistHighquality() async {
    var res =  await Http().dioGet("/top/playlist/highquality?before=1503639064232&limit=10&cat=流行");
    if(!(res is bool)) {
      return res;
    }
  }

  // banner
  Future banner() async {
    var res = await Http().dioGet('/banner?type=2');
    if(!(res is bool)) {
      return res;
    }
  }
}