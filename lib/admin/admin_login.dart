import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/admin_home.dart';
import 'package:survey/admin/admin_page.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  late SharedPreferences prefs;
  final AdminController controller = Get.find<AdminController>();
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
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(title: const Text("Admin"), centerTitle: true, elevation: 1),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: getW(context),
            height: getH(context),
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getH(context) * 0.1,
              ),
              Image.asset("assets/images/home.png"),
              SizedBox(height: getH(context) * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: getW(context) * 0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                    onChanged: (value) {
                      controller.email.value = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: getW(context) * 0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                    onChanged: (value) {
                      controller.password.value = value;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String email = "";
                  String password = "";
                  await FirebaseFirestore.instance
                      .collection('admin')
                      .doc("gT0VHZ5eHhr1DV7yx53G")
                      .get()
                      .then((value) {
                    email = value['email'];
                    password = value['password'];
                  });
                  if (controller.email.value == email &&
                      controller.password.value == password) {
                    await prefs.setBool('login', true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdminPage()));
                  } else {
                    snackbar(context);
                  }
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
                      child: const Text("लॉगिन करें",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
