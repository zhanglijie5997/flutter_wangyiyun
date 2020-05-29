import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wangyiyun/Components/Toast.dart';
import 'package:wangyiyun/Mobx/Counter.dart';
import 'package:wangyiyun/Utils/UrlLauncher/urlLauncher.dart';

class My extends StatefulWidget {
  My({Key key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  String _cacheSizeStr = '';
  double _cacheValue = 0;
  PackageInfo _packageInfo ;
  ///加载缓存
  Future<Null> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      // print("Directory: $tempDir");

      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
      print('临时目录大小: ' + value.toString());
      Toast().showText('临时目录大小: ' + value.toString());
      // print(value != 0);
      setState(() {
        _cacheSizeStr = _renderSize(value);
        _cacheValue = value;
      });
    } catch (err) {
      // print(err);
    }
  }

  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
    // print(file);
    // print(22222);
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        var children;
        double total = 0;
        children = file.listSync();
        if (children != null)
          for (final FileSystemEntity child in children) {
            total += await _getTotalSizeOfFilesInDir(child);
          }

        return total;
      }
      return 0;
    } catch (e) {
      // print(e);
      return 0;
    }
  }

  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  void _clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    // print(tempDir);
    //删除缓存目录
    try {
      await delDir(tempDir);
      await loadCache();
    } catch (e) {

    }
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        print('children:$children');
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
        await file.delete(recursive: true);
      }
      // this.loadCache();
      print('file:$file');
    } catch (e) {}
  }


  Future<void> getPackageInfo() async{
    PackageInfo result = await PackageInfo.fromPlatform();
    print('package: ${result.version}');
    this.setState(() {
      _packageInfo = result;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadCache();
    this.getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, counterState, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("我的"),
          ),
          backgroundColor: counterState.color,
          body: Column(
            children: <Widget>[
              IconButton(
                  onPressed: () async {
                    if (this._cacheValue == 0) {
                      Toast().showText("缓存已经清理完");
                    } else {
                      this._clearCache();
                    }
                    // bool result = await UrlLauncher.openBrow('https://www.baidu.com');
                  },
                  icon: Icon(Icons.add),
                  color: Colors.red),
              Text('缓存$_cacheSizeStr', style: TextStyle(color: Colors.red)),
              this._packageInfo != null ? Text('版本号: ${ _packageInfo.version}', style: TextStyle(color: Colors.red),) : Text('')
            ],
          ));
    });
  }
}
