import 'package:flutter/material.dart';
import 'package:flutter_prepared/ui/friend_page.dart';
import 'package:flutter_prepared/ui/home_page.dart';
import 'package:flutter_prepared/ui/login_page.dart';
import 'package:flutter_prepared/ui/profile_page.dart';
import 'package:flutter_prepared/ui/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prepared',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/profile": (context) => ProfilePage(),
        "/friend": (context) => FriendPage(),
      },
    );
  }
}
