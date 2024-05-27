import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/admin_home.dart';
import 'package:survey/admin/users.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class CreateUser extends StatelessWidget {
  CreateUser({super.key});

  final AdminController controller = Get.find<AdminController>();
  void addUser(BuildContext context) async {
    final userId = controller.userId.value;
    final password = controller.userPass.value;
    final phone = controller.userPhone.value;

    if (userId.isEmpty || password.isEmpty || phone.isEmpty) {
      snackbar(context);
      return;
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('userId already exists'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      await FirebaseFirestore.instance.collection('users').add({
        'userId': userId,
        'password': password,
        'phone': phone,
        "ward": controller.userWard.value
      });
      controller.userId.value = "";
      controller.userPass.value = "";
      controller.userPhone.value = "";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Create User"),
          centerTitle: true,
          elevation: 1,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Users()));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text("Users"),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getH(context) * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('वार्ड चुने', style: styleText()),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButton<int>(
                        alignment: Alignment.center,
                        underline: const SizedBox(
                          height: 1,
                        ),
                        dropdownColor: Colors.white,
                        hint: const Text('वार्ड चुने'),
                        value: controller.userWard.value,
                        items: List.generate(12, (index) {
                          int number = index + 1;
                          return DropdownMenuItem<int>(
                            value: number,
                            child: Text(number.toString()),
                          );
                        }),
                        onChanged: (int? newValue) {
                          controller.userWard.value = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getH(context) * 0.02),
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
                        hintText: "UserId",
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
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        hintText: "Phone No.",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (value) {
                        controller.userPhone.value = value;
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
                        controller.userPass.value = value;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => addUser(context),
                  child: Card(
                    elevation: 2,
                    child: Container(
                        height: 40,
                        width: 130,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text("उपयोगकर्ता बनाएँ",
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
      ),
    );
  }
}
