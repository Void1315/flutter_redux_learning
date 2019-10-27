import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_flutter_redux/actions/article_action.dart';
import 'package:my_flutter_redux/app_state.dart';
import 'package:my_flutter_redux/model/article_model.dart';
import 'package:redux/redux.dart';

class ArticlePage extends StatefulWidget {
  State<StatefulWidget> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    List<num> list = List(5);
    return Scaffold(
      appBar: AppBar(
        title: Text("添加titl"),
        actions: <Widget>[
          StoreConnector<AppState, _ViewModel>(
            converter: (store) => _ViewModel.create(store),
            builder: (context, viewModel) {
              return IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () {
                  viewModel.onAddItem(
                      ArticleModel(id: viewModel.articleList.length, title: "哈哈哈", author: "脑瘫码农"));
                },
              );
            },
          )
        ],
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.create(store),
        builder: (context, viewModel) {
          return ListView.builder(
            itemBuilder: (contentx, index) {
              return ListTile(
                  subtitle: Text((viewModel.articleList[index].id).toString()),
                  title: Text(viewModel.articleList[index].title),
                  leading: Text(viewModel.articleList[index].author),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      viewModel.onRemoveItem(viewModel.articleList[index]);
                    },
                  ));
            },
            itemCount: viewModel.articleList.length,
          );
        },
      ),
    );
  }
}

class _ViewModel {
  List<ArticleModel> articleList;

  Function(ArticleModel) onAddItem;

  Function(ArticleModel) onRemoveItem;

  _ViewModel({this.articleList, this.onAddItem, this.onRemoveItem});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(ArticleModel item) {
      store.dispatch(AddArticleItemAction(item: item));
    }

    _onRemoveItem(ArticleModel item) {
      store.dispatch(RemoveArticleItemAction(item: item));
    }

    return _ViewModel(
        articleList: store.state.articleListState,
        onAddItem: _onAddItem,
        onRemoveItem: _onRemoveItem);
  }
}
