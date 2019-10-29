import 'package:dio/dio.dart';
import './fetch.dart';
import './urls.dart';
const String prefix = "127.0.0.1"; // 接口地址前缀
class API{
  static Future<Response<dynamic>> getDrawerMenu()=>Fetch().get(prefix+Url.getDrawerMenu);
}