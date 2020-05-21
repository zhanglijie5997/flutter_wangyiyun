import 'package:amap_location/amap_location.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Mobx/IndexState.dart';
import 'package:wangyiyun/Page/Loading.dart';
import 'package:wangyiyun/Utils/Fluro/Fluro.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.red,
      statusBarColor: Colors.red
    )
  );
  await AMapLocationClient.setApiKey("8d5b6b94037ec861f2b9bc9438b80082");
  return runApp(MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => CounterState()),
        ChangeNotifierProvider(create: (context) => IndexState()),
      ], child: Myapp()),
    );
}

class Myapp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final router = new Router();
     Routes.configureRoutes(router);
     Application.router = router;
    return MaterialApp(
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      onGenerateRoute: Application.router.generator,
      home: Scaffold(
        body: Loading(),
      ),
    );
  }
}