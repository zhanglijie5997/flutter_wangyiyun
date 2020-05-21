import 'package:dio/dio.dart';
// import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:wangyiyun/Components/Toast.dart';

class Http extends InterceptorsWrapper{
  @override 
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }
  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }
  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    Toast().showText("网络错误");
    return super.onError(err);
  }
  
  Dio dio =  Dio(BaseOptions(
    baseUrl: 'http://172.247.127.68:3000/',
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: Headers.formUrlEncodedContentType
  ));
  Future dioGet(String path) async {
    try {
      Response response = await dio.get(path);
      return response.data;
    } catch (e) {
      Toast().showText("网络超时");
      return false;
    }
    
  }

  dioPost(String path, Map<String, dynamic> data) async {
    try {
      Response response = await dio.post(path, data: data);
      return response.data;
    } catch (e) {
      return false;
    }
  }

  dioPostFile(String path, Map<String, dynamic> data) async {
    data['file'] = await MultipartFile.fromFile('./text.txt', filename: 'upload.txt');
    FormData formData = FormData.fromMap(data);
    try {
      Response response = await dio.post(path, data: formData);
      return response.data;
    } catch (e) {
      return false;
    }
  }
}