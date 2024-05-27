import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/controller.dart';
import 'package:survey/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Get.put(HomeController());
  Get.put(AdminController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBUtGD_VQ1NvZdQBRPWsws5ByDl4mMfiP8',
    appId: '1:922372477815:android:c516ee7b67aad6eb110772',
    messagingSenderId: '922372477815',
    projectId: 'panchayat-survey-58e4c',
    storageBucket: 'panchayat-survey-58e4c.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansDevanagari',
      ),
      home: const Splash(),
    );
  }
}
