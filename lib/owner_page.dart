import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/create_user.dart';
import 'package:survey/controller.dart';
import 'package:survey/start.dart';
import 'package:survey/utils/utils.dart';

class OwnerPage extends StatefulWidget {
  const OwnerPage({super.key});

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  final AdminController controller = Get.find<AdminController>();
  final HomeController homeController = Get.find<HomeController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("सर्वेक्षण सूची"),
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
            future: FirebaseFirestore.instance
                .collection("details")
                .where("userId", isEqualTo: homeController.userId.value)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No documents found'));
              } else {
                var value = snapshot.data!.docs;
                return SizedBox(
                  height: getH(context) * 0.97,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                          margin:
                              const EdgeInsets.only(top: 6, left: 2, right: 2),
                          elevation: 1,
                          color: Colors.yellow.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                value[i]['image'] != ""
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        child: Image.network(value[i]['image'],
                                            width: getW(context) * 0.25,
                                            height: getH(context) * 0.1,
                                            fit: BoxFit.cover),
                                      )
                                    : SizedBox(
                                        width: getW(context) * 0.25,
                                      ),
                                SizedBox(
                                  width: getW(context) * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: getW(context) * 0.57,
                                          child: Text(
                                            value[i]['name']
                                            // +(value[i]['email'] ?? "")
                                            ,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            homeController.isOwner.value = true;
                                            homeController.docId.value =
                                                value[i].id;
                                            await homeController
                                                .getData(value[i].id);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Start()));
                                          },
                                          child: const Icon(Icons.edit,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: getW(context) * 0.5,
                                      child: Text(
                                          "Serial- #" + value[i]['serial'] ??
                                              "",
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var data = value[i].data();
                                        var pdfData =
                                            await controller.generatePdf(data);
                                        await Printing.layoutPdf(
                                            onLayout:
                                                (PdfPageFormat format) async =>
                                                    pdfData);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: getW(context) * 0.42,
                                            child: Text(
                                              value[i]['userId'] ?? "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Text(
                                            "पीडीएफ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 1,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
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
