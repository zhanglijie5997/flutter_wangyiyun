import 'package:flutter/material.dart';

class VideoCom extends StatefulWidget {
  final Map<String, dynamic> item;
  VideoCom({Key key, this.item}) : super(key: key);

  @override
  _VideoComState createState() => _VideoComState();
}

class _VideoComState extends State<VideoCom> {
  @override
  void initState() { 
    super.initState();
    // print(this.widget.item);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 200,
        margin: EdgeInsets.only(bottom: 10),
       child: Column(
         children: <Widget>[
           Container(
             height: 200,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10)),
               image: DecorationImage(
                 image: NetworkImage(this.widget.item['picUrl']),
                 fit: BoxFit.cover
                )
             ),
             child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal, 
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/triangle.png', width: 15, height: 15,),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(this.widget.item['playCount'] > 10000 ? (this.widget.item['playCount'] / 10000).toString() + '万': (this.widget.item['playCount']).toString(),
                              style: TextStyle(
                                color: Colors.white
                              ),
                          ),
                        )
                        
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/equalizer.png', width: 16, height: 16,),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text("09:08", style: TextStyle(
                            color: Colors.white
                          )),
                        )
                      ],
                    ),
                  )
              ],),
             ) 
             
           )
         ],
       ),
    );
  }
}