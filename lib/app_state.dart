import 'package:flutter/material.dart';
import 'package:my_flutter_redux/actions/article_action.dart';
import 'package:my_flutter_redux/model/article_model.dart';

import 'actions/theme_action.dart';
import 'model/theme_model.dart';

class AppState {
  ThemeModel themeState; //保存我们的主题状态
  List<ArticleModel> articleListState; //保存文章list状态
  AppState({this.themeState, this.articleListState});
  /*
   * 命名的构造方法
   * 这里用来初始化
   */
  AppState.initialState() {
    themeState = ThemeModel(themeData: ThemeData.dark());
    articleListState = List<ArticleModel>();
  }
}

/**
 * 定义Reducer
 */
AppState appReducer(AppState state, action) {
  return AppState(
    themeState: ThemeReducer(state.themeState, action),
    articleListState: ArticlesReducer(state.articleListState, action),
  );
}
