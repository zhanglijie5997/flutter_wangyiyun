import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Toast {
   void showText(String title) {
    BotToast.showText(
      text: title,
      align: Alignment.center,
      textStyle: TextStyle(fontSize: 12, color: Colors.white)
      // animationDuration: Duration(seconds: 2),
      // toastBuilder: (cancelFunc) => Text('测试'),
      // duration: Duration(seconds: 3)
    ); //弹出简单通知Toast
  }

  
}