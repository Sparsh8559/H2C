import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:h2c/Home_page.dart';
import 'package:h2c/loginpage.dart';
import 'package:h2c/map.dart';
import 'package:h2c/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => Mylogin(),
      'register':(context)=>MyRegister(),
      'home':(context)=>homeScreen(),
      'map':(context)=> mapRoute(),
    },
  ));
}
