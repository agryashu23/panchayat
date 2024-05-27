import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/admin/admin_home.dart';
import 'package:survey/admin/admin_login.dart';
import 'package:survey/admin/admin_page.dart';
import 'package:survey/controller.dart';
import 'package:survey/login_page.dart';
import 'package:survey/questions.dart';
import 'package:survey/start.dart';
import 'package:survey/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();
  late SharedPreferences prefs;

  Future<void> initiate() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initiate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("सर्वेक्षण"),
        elevation: 0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              final bool? login = prefs.getBool('login');
              if (login == true) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AdminPage()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminLogin()));
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text("Admin"),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: getW(context),
            height: getH(context),
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset("assets/images/home.png"),
                const SizedBox(height: 5),
                const Text("ग्राम पंचायत सर्वेक्षण",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    controller.isOwner.value = false;
                    await controller.clearAllData();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text("शुरू करें",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
