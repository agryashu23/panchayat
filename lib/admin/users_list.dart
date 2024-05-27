import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/admin/users.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class UserListItem extends StatefulWidget {
  final dynamic userDoc; // Pass the user document data here

  const UserListItem({super.key, required this.userDoc});

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.only(top: 6, left: 2, right: 2),
        elevation: 1,
        color: Colors.yellow.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: getW(context) * 0.57,
                        child: Text(
                          "userId- " + widget.userDoc['userId'],
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  controller.isEdit.value
                      ? textField2(controller.pass.value, TextInputType.text,
                          getW(context) * 0.5, "New password", (value) {
                          controller.pass.value = value;
                        })
                      : Text("password- " + widget.userDoc['password'],
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500)),
                  Text("ward- ${widget.userDoc['ward']}",
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                  Text("phone- " + widget.userDoc['phone'],
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (controller.isEdit.value) {
                    // Save new password
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.userDoc.id)
                        .update({'password': controller.pass.value}).then((_) {
                      controller.isEdit.value = false;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Users()));
                    });
                  } else {
                    controller.isEdit.value = true; // Enable edit mode locally
                  }
                },
                child: Text(controller.isEdit.value ? "Save" : "Edit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
