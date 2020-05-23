import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wangyiyun/Components/Toast.dart';

class UrlLauncher {
  /// 拨打电话
  /// _phone 电话
  /// eg: phone(13650653625)
  static Future<bool> phone(int _phone) async{
    String url = 'tel:$_phone';
    bool canLaunchUrl = await canLaunch(url);
    if(!canLaunchUrl) {
      Toast().showText("您的手机不具备一键拨打电弧功能");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 打开地图 
  /// _str gaode | baidu | qqmap | ''
  /// eg: openMap('', 12.34, 12.34)
  static Future<bool> openMap(String _str, double latitude, double longitude) async{
    String url = 'http://maps.apple.com'; // 默认手机自带地图
    switch (_str) {
      case 'gaode':
        if(latitude != null && longitude != null) {
          url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
        }else {
          url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi';
        }
        break;
      case 'qqmap':
        if(longitude != null && longitude != null) {
          url = 'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
        }else {
           url = 'qqmap://map/routeplan';
        }
        break;
      case 'baidu':
        if(longitude != null && longitude != null) {
          url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
        }else {
          url = 'baidumap://map/direction';
        }
        break;
      default:
        if(longitude != null && longitude != null) {
          url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';
        }
        break;
    }
    bool canLaunchUrl = await canLaunch(url); 
    if(!canLaunchUrl) {
      Toast().showText("您的手机未安装此地图");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 发送短信
  /// eg: openSms(110)
  static Future<bool> openSms(int _phone) async{
    String url = 'sms:$_phone';
    bool canLaunchUrl = await canLaunch(url);
     if(!canLaunchUrl) {
      Toast().showText("您的手机不具备发送短信功能");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 打开网页
  /// eg: openBrow('https://www.baidu.com');
  static Future<bool> openBrow(String _url) async{
    String url = _url;
    bool canLaunchUrl = await canLaunch(url);
     if(!canLaunchUrl) {
      Toast().showText("打开网页失败");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }
}