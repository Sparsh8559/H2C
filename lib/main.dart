import 'package:flutter/material.dart';
import 'package:h2c/loginpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => Mylogin()
    },
  ));
}
