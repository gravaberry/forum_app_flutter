import 'package:flutter/material.dart';
import 'package:forum_app_flutter_v2/views/home_page.dart';
import 'package:forum_app_flutter_v2/views/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:forumapp_flutter/views/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token == null ? const LoginPage() : const HomePage(),
    );
  }
}
