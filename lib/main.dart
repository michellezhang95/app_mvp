import 'package:flutter/material.dart';
import 'package:app_mvp/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(), routes: <String, WidgetBuilder>{
      '/landingpage:': (BuildContext context) => new MyApp(),
      '/signup': (BuildContext context) => new SignupPage(),
      '/homepage': (BuildContext context) => new HomePage(),
    });
  }
}
