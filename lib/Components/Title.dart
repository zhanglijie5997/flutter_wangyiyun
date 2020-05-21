import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wangyiyun/Components/Listen.dart';

class Nav extends StatefulWidget {
  Nav({Key key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> { 
  TextEditingController _textController;
  String _textVal = ''; // text 输入文字
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03, left: MediaQuery.of(context).size.width * 0.03),
      height: 50,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/microphone.png",
              width: 25,
              height: 25,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  width: 250,
                  height: 40,
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(44, 45, 46, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Flex(direction: Axis.horizontal, children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 10),
                      child: Image.asset(
                        'images/seach.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      child: CupertinoTextField(
                        keyboardAppearance: Brightness.dark,
                        placeholder: '请输入文字',
                        placeholderStyle:
                            TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                        maxLines: 1,
                        onChanged: (String _text) {
                          this.setState(() {
                            _textVal = _text;
                          });
                        },
                        controller: _textController,
                        cursorWidth: 2,
                        cursorColor: Colors.red,
                        // textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        decoration: BoxDecoration(
                            // contentPadding: EdgeInsets.only(bottom: 14),
                            // border: InputBorder.none,
                            ),
                        inputFormatters: <TextInputFormatter>[
                          // LengthLimitingTextInputFormatter(12)
                        ],
                      ),
                    )
                  ]))),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Listen(),
          )
        ],
      ),
    );
  }
}
