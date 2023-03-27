import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './UI/forms/login_page.dart';

Future<void> main() async {
  runApp(const MyApp());
  var box = await Hive.openBox("mybox");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginForm(),
    );
  }
}

