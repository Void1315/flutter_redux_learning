import 'dart:convert';

class ArticleModel {
  String author;

  num id;

  String title;

  ArticleModel({this.id, this.title, this.author});

  ArticleModel.fromJson(Map<String,dynamic> json){
    this.author = json['author'];
    this.id = json['id'];
    this.title = json['title'];
  }
  ArticleModel.fromJsonString(String jsonStr){
    Map<String,dynamic> json = JsonCodec().decode(jsonStr);
    ArticleModel.fromJson(json);
  }
}
