import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_flutter_redux/app_state.dart';
import 'package:my_flutter_redux/model/theme_model.dart';
import 'package:redux/redux.dart';

import 'actions/theme_action.dart';
import 'pages/articles_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store =
        Store<AppState>(appReducer, initialState: AppState.initialState());
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: store.state.themeState.themeData,
            routes:<String, WidgetBuilder>{
              "/article":(BuildContext context) => ArticlePage(),
            } ,
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(child: Text("切换页面"),onPressed: (){
                Navigator.of(context).pushNamed('/article');
              },)
            ],
          ),
        ),
        floatingActionButton: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel.create(store),
          builder: (context, viewModel) {
            return FloatingActionButton(
              onPressed: () {
                _incrementCounter();
                viewModel.onSetThemeData(viewModel.themeData == ThemeData.dark()
                    ? ThemeData.light()
                    : ThemeData.dark());
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          },
        ));
  }
}

class _ViewModel {
  ThemeData themeData;
  Function(ThemeData) onSetThemeData;
  _ViewModel({
    this.themeData,
    this.onSetThemeData,
  });
  factory _ViewModel.create(Store<AppState> store) {
    _onSetThemeData(ThemeData themeData) {
      store.dispatch(SetThemeDataAction(themeData: themeData));
    }


    return _ViewModel(
      themeData: store.state.themeState.themeData,
      onSetThemeData: _onSetThemeData,
    );
  }
}
