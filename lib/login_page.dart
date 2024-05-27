import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/admin_home.dart';
import 'package:survey/controller.dart';
import 'package:survey/start.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final HomeController controller = Get.find<HomeController>();

  void checkUser(BuildContext context) async {
    final userId = controller.userId.value;
    final password = controller.password.value;

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      final user = documents.first.data() as Map<String, dynamic>;
      if (user['password'] == password) {
        await controller.clearAllData();
        controller.ward.value = user['ward'].toString();
        controller.userId.value = user['userId'].toString();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Start()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Email does not exist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('userId does not exist'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(title: const Text("Login"), centerTitle: true, elevation: 1),
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
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      hintText: "userId",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                    onChanged: (value) {
                      controller.userId.value = value;
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
                onTap: () => checkUser(context),
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
