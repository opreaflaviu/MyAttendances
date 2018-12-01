import 'package:my_attendances/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:my_attendances/pages/landing_page.dart';
import 'package:my_attendances/pages/login_page.dart';
import 'package:my_attendances/pages/register_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(routes: <String, WidgetBuilder>{
      'landing_page': (BuildContext context) => new LandingPage(),
      'login_page': (BuildContext context) => new LoginPage(),
      'register_page': (BuildContext context) => new RegisterPage(),
      'main_page': (BuildContext context) => new MainPage()
    }, home: LandingPage());
  }
}
