import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import '../config/env.dart';
class Fetch extends DioForNative {
  static const FIX = "lib/json";
  factory Fetch()=>_getInstance();
  static Fetch get instance => _getInstance();
  static Fetch _instance;
  Fetch._internal() {
    // 初始化
    this.interceptors.add(InterceptorsWrapper(onRequest: _onRequest));
  }
  static Fetch _getInstance() {
    if (_instance == null) {
      _instance = new Fetch._internal();
    }
    return _instance;
  }
  _onRequest(RequestOptions options){
    if(Env.IS_DEVELOPMENT){
      var reg = RegExp(r"(/\S+)(?:\?|$)");
      return this.resolve(_readJsonFile(reg.firstMatch(options.path).group(0)));
    }
    return options;
  }
  _readJsonFile(String filePath) async{
    final String json = await rootBundle.loadString(FIX+filePath+".json");
    return json;
  }
}

