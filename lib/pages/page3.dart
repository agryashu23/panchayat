import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    homeController
        .initializeDataList(int.tryParse(homeController.people.value) ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
          child: Column(
        children: [
          SizedBox(
            height: getH(context) * 0.02,
          ),
          Text(
            "12. सदस्यों की सूचि",
            style: styleText(),
          ),
          SizedBox(
            height: (int.tryParse(homeController.people.value) ?? 0) <= 4
                ? getH(context) *
                    (int.tryParse(homeController.people.value) ?? 0) *
                    0.16
                : getH(context) * 0.7,
            child: Obx(
              () => ListView.builder(
                itemCount: int.tryParse(homeController.people.value),
                padding: EdgeInsets.only(top: getH(context) * 0.04),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: getH(context) * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            Text("${index + 1}."),
                            const SizedBox(
                              width: 8,
                            ),
                            textField2(
                              homeController.dataList[index]['name'] ?? '',
                              TextInputType.name,
                              getW(context) * 0.28,
                              "नाम",
                              (value) {
                                homeController.dataList[index]['name'] = value;
                              },
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            textField2(
                              homeController.dataList[index]['adhaar'] ?? '',
                              TextInputType.number,
                              getW(context) * 0.4,
                              "आधार नंबर",
                              (value) {
                                homeController.dataList[index]['adhaar'] =
                                    value;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            textField2(
                              homeController.dataList[index]['age'] ?? '',
                              TextInputType.number,
                              getW(context) * 0.15,
                              "आयु",
                              (value) {
                                homeController.dataList[index]['age'] = value;
                              },
                            ),
                            SizedBox(
                              width: getW(context) * 0.15,
                            ),
                            textField2(
                              homeController.dataList[index]['mobile'] ?? '',
                              TextInputType.number,
                              getW(context) * 0.4,
                              "मोबाइल नंबर",
                              (value) {
                                homeController.dataList[index]['mobile'] =
                                    value;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textField2(
                              homeController.dataList[index]['account'] ?? '',
                              TextInputType.number,
                              getW(context) * 0.4,
                              "खाता संख्या",
                              (value) {
                                homeController.dataList[index]['account'] =
                                    value;
                              },
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            textField2(
                              homeController.dataList[index]['ifsc'] ?? '',
                              TextInputType.text,
                              getW(context) * 0.3,
                              "आईएफएससी",
                              (value) {
                                homeController.dataList[index]['ifsc'] = value;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: textField2(
                            homeController.dataList[index]['accountName'] ?? '',
                            TextInputType.text,
                            getW(context) * 0.4,
                            "खाता नाम",
                            (value) {
                              homeController.dataList[index]['accountName'] =
                                  value;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: GestureDetector(
                onTap: () {
                  if (homeController.dataList.isEmpty) {
                    snackbar(context);
                  } else {
                    homeController.index.value += 1;
                  }
                },
                child: btn()),
          )
        ],
      )),
    );
  }
}
