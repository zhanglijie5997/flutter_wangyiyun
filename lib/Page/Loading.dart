import 'package:flutter/material.dart';
import 'package:wangyiyun/Router/Router.dart';
class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{
  Animation<double> _animate;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, duration: const Duration(seconds: 3),
    )..addStatusListener((status) { 
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => Router()
        ), (route) => route == null);
      }
    });
    _animate = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animate, 
      child: Container(
       child: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         child: Image.asset("images/index.jpeg"),
       ),
    ),) ;
  }
}