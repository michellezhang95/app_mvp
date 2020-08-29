import 'package:app_mvp/screens/existing-cards.dart';
import 'package:flutter/material.dart';
import 'package:app_mvp/screens/login.dart';
import 'package:app_mvp/screens/homepage.dart';
import 'package:app_mvp/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Prototype',
        home: HomePage(),
        initialRoute: '/homepage',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        routes: <String, WidgetBuilder>{
          '/landingpage:': (BuildContext context) => new MyApp(),
          '/signup': (BuildContext context) => new SignupPage(),
          '/homepage': (BuildContext context) => new HomePage(),
          '/existing-cards': (BuildContext context) => ExistingCardsPage()
        });
  }
}
