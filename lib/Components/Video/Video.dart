import 'package:flutter/material.dart';

class VideoItem extends StatefulWidget {
  final bool active;
  final Color color;
  final Map<String, dynamic> item;
  final Function changeCurrent;
  final int index;
  final Function changeScroll;
  final int id;
  VideoItem({Key key, this.active, 
             this.color, this.item, this.changeCurrent, 
             this.index, this.changeScroll, this.id}) : super(key: key);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: globalKey,
      onTap: () {
        this.widget.changeCurrent(this.widget.index, this.widget.id);
        RenderObject renderObject = context.findRenderObject();
        var vector3 = renderObject.getTransformTo(null)?.getTranslation();
        RenderBox renderBox = this.globalKey.currentContext.findRenderObject();
        var offset =  renderBox.localToGlobal(Offset.zero);
        print(offset.dx);
        // this.widget.changeScroll(vector3.x);
      },
      child: Container(
        // padding: EdgeInsets.only(left: 7, right: 7),
        decoration: BoxDecoration(
          border: Border(
            // bottom: BorderSide(
            //   width: 2,
            //   color: this.widget.active ? Colors.red : this.widget.color
            // )
          )
        ),
        child: Center(
          child: Text(this.widget.item["name"], style: TextStyle(
            color: Colors.white,
            fontSize: this.widget.active ? 22:20,
          ))
        ) ,
      ),
    ) ;
  }
}