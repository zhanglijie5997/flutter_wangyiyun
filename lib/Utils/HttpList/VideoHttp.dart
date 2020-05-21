import 'package:wangyiyun/Utils/Http/Http.dart';

class VideoHttp {
  // 推荐 mv
  static personalizedMv() async{
    var result = await Http().dioGet('/personalized/mv');
    if(!(result is bool)) {
      return result;
    }
  }
  // 获取视频标签列表
  static videoGroupList() async{
    var result = await Http().dioGet('/video/group/list');
    if(!(result is bool)) {
      return result;
    }
  }
}