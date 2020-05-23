import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCom extends StatefulWidget {
  final List<dynamic> list;
  SwiperCom({Key key, this.list}) : super(key: key);

  @override
  _SwiperComState createState() => _SwiperComState();
}

class _SwiperComState extends State<SwiperCom> {
  @override
  void initState() {
    super.initState();
  }

  Color _color(String type) {
    switch (type) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       width: MediaQuery.of(context).size.width * 0.95,
       height: 130,
       child: Swiper(
         itemCount: this.widget.list.length,
         itemBuilder: (BuildContext context, int index) {
           return ClipRRect(
             borderRadius: BorderRadius.circular(6.0),
             child: Stack(
               children: <Widget>[
                 Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 200,
                   child: Image.network(this.widget.list[index]['pic'], fit: BoxFit.fitWidth,),
                 ),
                  
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 18,
                      child: Center(
                        child: Text(this.widget.list[index]['typeTitle'], style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                        )),
                      ) ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
                        color: this._color(this.widget.list[index]['titleColor']),
                      ),
                    )
                  )
               ],
             )
           );
         },
        viewportFraction: 1,
        scale: 0.9,
        loop: true,
        autoplay: true,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 5)
        ),
        //  layout: SwiperLayout.DEFAULT,
         onTap: (int index) {
           print(index);
         },
       ),
    );
  }
}