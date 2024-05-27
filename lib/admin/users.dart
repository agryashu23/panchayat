import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/create_user.dart';
import 'package:survey/admin/users_list.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final AdminController controller = Get.find<AdminController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<QuerySnapshot> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = FirebaseFirestore.instance.collection("users").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("उपयोगकर्ताओं की सूची"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: getW(context),
            height: getH(context),
            fit: BoxFit.cover,
          ),
          FutureBuilder(
            future: _usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No documents found'));
              } else {
                return SizedBox(
                  height: getH(context) * 0.97,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        return UserListItem(
                            key: ValueKey(snapshot.data!.docs[i].id),
                            userDoc: snapshot.data!.docs[i]);
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
