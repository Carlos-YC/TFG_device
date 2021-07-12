import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_selection/src/config/config.dart';
import 'package:device_selection/src/pages/init_page.dart';
import 'package:device_selection/src/pages/login_page.dart';
import 'package:device_selection/src/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SupermarketApp.auth = FirebaseAuth.instance;
  SupermarketApp.sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Selection',
      home: InitPage(),
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
          primaryColor: Colors.green, visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
