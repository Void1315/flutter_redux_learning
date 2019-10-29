import 'dart:convert';

import 'package:my_flutter_redux/api/apis.dart';
import 'package:my_flutter_redux/app_state.dart';
import 'package:my_flutter_redux/model/article_model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AddArticleItemAction {
  ArticleModel item;
  AddArticleItemAction({this.item});

  static List<ArticleModel> addArticleItem(
      List<ArticleModel> list, AddArticleItemAction action) {
    list?.add(action?.item);
    return list;
  }
}

ThunkAction<AppState> getArticleData =(Store<AppState> store) async {
    String jsonStr = (await API.getDrawerMenu()).data;
    var jsonData = JsonCodec().decode(jsonStr);
    for(var i=0;i<jsonData.length;i++){
        store.dispatch(AddArticleItemAction(item: ArticleModel.fromJson(jsonData[i])));
    }
};

class RemoveArticleItemAction {
  ArticleModel item;
  RemoveArticleItemAction({this.item});

  static List<ArticleModel> removeArticleItem(
      List<ArticleModel> list, RemoveArticleItemAction action) {
    list.remove(action.item);
    return list;
  }
}

/*
 * 绑定Action与动作
 */
final ArticlesReducer = combineReducers<List<ArticleModel>>([
  TypedReducer<List<ArticleModel>, AddArticleItemAction>(
      AddArticleItemAction.addArticleItem),
  TypedReducer<List<ArticleModel>, RemoveArticleItemAction>(
      RemoveArticleItemAction.removeArticleItem),
]);
