import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/admin/admin_controller.dart';
import 'package:survey/admin/create_user.dart';
import 'package:survey/controller.dart';
import 'package:survey/homepage.dart';
import 'package:survey/start.dart';
import 'package:survey/utils/utils.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AdminController controller = Get.find<AdminController>();
  final HomeController homeController = Get.find<HomeController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("सर्वेक्षण सूची"),
        centerTitle: false,
        actions: const [],
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
            children: [
              const SizedBox(
                height: 8,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "फ़िल्टर करें",
              //       style: styleText(),
              //     ),
              //     const SizedBox(
              //       width: 30,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         controller.selectedQuestion.value = "";
              //         controller.selectedAnswer.value = "";
              //         controller.selectedWard.value = "";
              //       },
              //       child: const Text(
              //         "Clear",
              //         style: TextStyle(
              //             decoration: TextDecoration.underline,
              //             color: Colors.purple),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     child: DropdownButton<String>(
              //       value: controller.selectedQuestion.value.isEmpty
              //           ? null
              //           : controller.selectedQuestion.value,
              //       hint: const Text('Select Question'),
              //       items: <String>[
              //         '60 वर्ष से ऊपर क सदस्य यदि हा तो पेंशन का लाभ?',
              //         'पिछले 2 वर्ष में लड़की की शादी हुई तो कन्या विवाह योजना का लाभ?',
              //         "प्रधानमंत्री आवास प्राप्त हुआ या नहीं? यदि हां तो आवास पूरा हुआ या नहीं? ",
              //         "आवास का मजदूरी प्राप्त है या नहीं?नहीं मिलने का कारण?",
              //         "शौचालय बना या नहीं? यदि हां तो लाभ मिला या नहीं? नहीं मिलने का कारण",
              //         "पेय जल नल लगा या नहीं? यदि नहीं तो कारण",
              //         "चापाकल या नल की पानी की व्यवस्था? सोख्ता निर्मित किया जा सकता है या नहीं?",
              //         "स्वच्छता पर्ची भुगतान किया गया है या नहीं? यदि हाँ तो कितने महीने का",
              //         "स्वच्छता कर्मी प्रतिदिन आता है या नहीं?",
              //         "पिछले 2 वर्षों में परिवार के किसी सदस्य का जन्म या मृत्यु हुई है तो प्रमाण पत्र निर्गत है या नहीं?",
              //         "यदि घर में किसी की मृत्यु हुई है तो पारिवारिक योजना का लाभ मिला है?",
              //         'कबीर अंत्येष्टि का लाभ मिला है या नहीं?',
              //       ].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (newValue) {
              //         controller.setQuestion(newValue ?? '');
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     DropdownButton<String>(
              //       value: controller.selectedAnswer.value.isEmpty
              //           ? null
              //           : controller.selectedAnswer.value,
              //       hint: const Text('Select Answer'),
              //       items: <String>['हाँ', 'नहीं'].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (newValue) {
              //         controller.setAnswer(newValue ?? '');
              //       },
              //     ),
              //     DropdownButton<String>(
              //       value: controller.selectedWard.value.isEmpty
              //           ? null
              //           : controller.selectedWard.value,
              //       hint: const Text('Select Ward'),
              //       items:
              //           List.generate(12, (index) => (index + 1).toString())
              //               .map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text("Ward $value"),
              //         );
              //       }).toList(),
              //       onChanged: (newValue) {
              //         controller.setWard(newValue ?? '');
              //       },
              //     ),
              //   ],
              // ),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection("details").get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Internet connection error. Please try again'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data exists.'));
                  } else {
                    // var filteredDocuments =
                    //     controller.filterDocuments(snapshot.data!);
                    return SizedBox(
                      height: getH(context) * 0.7,
                      child: ListView.builder(
                          padding:
                              const EdgeInsets.only(top: 5, left: 2, right: 2),
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            var value = snapshot.data!.docs;

                            return Card(
                              margin: const EdgeInsets.only(
                                  top: 6, left: 2, right: 2),
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            child: Image.network(
                                                value[i]['image'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                homeController.isOwner.value =
                                                    true;
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
                                              "Serial- #" +
                                                      value[i]['serial'] ??
                                                  "",
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            var data = value[i].data();
                                            var pdfData = await controller
                                                .generatePdf(data);
                                            await Printing.layoutPdf(
                                                onLayout: (PdfPageFormat
                                                        format) async =>
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Text(
                                                "पीडीएफ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: 1,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: getW(context) * 0.42,
                                          child: Text(
                                            "Ward- " + value[i]['ward'] ?? "",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
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
        ],
      ),
    );
  }
}
