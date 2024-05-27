import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/admin/admin_home.dart';
import 'package:survey/admin/create_user.dart';
import 'package:survey/admin/users.dart';
import 'package:survey/homepage.dart';
import 'package:survey/utils/utils.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
        title: const Text("Admin"),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              await prefs.setBool('login', false);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text("Logout"),
            ),
          ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AdminHome()));
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: getW(context) * 0.7,
                      alignment: Alignment.center,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: const Text("Survey"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CreateUser()));
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: getW(context) * 0.7,
                      alignment: Alignment.center,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: const Text("Create user"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Users()));
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: getW(context) * 0.7,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: const Text("Users"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Card(
                  elevation: 2,
                  child: Container(
                    alignment: Alignment.center,
                    width: getW(context) * 0.7,
                    height: 70,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: const Text("Filter"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
