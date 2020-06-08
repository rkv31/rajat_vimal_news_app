import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/screens/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    bloc.closeSink();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
        home: HomePage(snapshot.data),
      ),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  set changeTheme(bool data) => _themeController.sink.add(data);
  get darkThemeEnabled => _themeController.stream;

  void closeSink() {
    _themeController.sink.close();
  }
}

final bloc = Bloc();
