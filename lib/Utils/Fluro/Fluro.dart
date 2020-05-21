import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:wangyiyun/Page/Rank.dart';
import 'package:wangyiyun/Page/Scan.dart';

class Application {
  static Router router;
}

class Routes {

  static String rankPage = '/rank';

  static String scanPage = '/scan';

  static Router router;
 
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('not found');
    });
    router.define(rankPage, handler: Handler(
      handlerFunc: (context, params) => Rank(),
    ), transitionType: TransitionType.cupertino);

    router.define(scanPage, handler: Handler(
      handlerFunc: (context, params) => Scan()
    ), transitionType: TransitionType.cupertino);
  }
}