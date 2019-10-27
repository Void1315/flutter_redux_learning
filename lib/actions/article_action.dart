import 'package:my_flutter_redux/model/article_model.dart';
import 'package:redux/redux.dart';

class AddArticleItemAction {
  ArticleModel item;
  AddArticleItemAction({this.item});

  static List<ArticleModel> addArticleItem(
      List<ArticleModel> list, AddArticleItemAction action) {
    list?.add(action?.item);
    return list;
  }
}

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
