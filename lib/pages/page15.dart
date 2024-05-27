import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page15 extends StatefulWidget {
  const Page15({super.key});

  @override
  State<Page15> createState() => _Page15State();
}

class _Page15State extends State<Page15> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                  "17. पिछले 2 वर्षों में परिवार के किसी सदस्य का जन्म हुआ है?",
                  style: styleText()),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: getW(context),
                child: TextFormField(
                  initialValue: controller.pariwarjanm.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                  onChanged: (value) {
                    controller.pariwarjanm.value = value;
                    controller.initializevpariwarjanmList(
                        int.tryParse(controller.pariwarjanm.value) ?? 0);
                  },
                ),
              ),
            ),
            controller.pariwarjanmList.isNotEmpty
                ? SizedBox(
                    height: getH(context) * 0.3,
                    child: ListView.builder(
                      itemCount: int.tryParse(controller.pariwarjanm.value),
                      padding: const EdgeInsets.only(top: 16.0),
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${index + 1}."),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textField2(
                                      controller.pariwarjanmList[index]
                                              ['name'] ??
                                          '',
                                      TextInputType.name,
                                      MediaQuery.of(context).size.width * 0.4,
                                      "नाम",
                                      (value) {
                                        controller.pariwarjanmList[index]
                                            ['name'] = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      const Text("पुरुष"),
                                      Radio<bool>(
                                        value: false,
                                        groupValue:
                                            controller.pariwarjanmList[index]
                                                    ['gender'] ??
                                                false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.pariwarjanmList[index]
                                                ['gender'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      const Text("महिला"),
                                      Radio<bool>(
                                        value: true,
                                        groupValue:
                                            controller.pariwarjanmList[index]
                                                    ['gender'] ??
                                                false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.pariwarjanmList[index]
                                                ['gender'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      const Text("प्रमाण पत्र निर्गत"),
                                      Switch(
                                        value: controller.pariwarjanmList[index]
                                                ['pramad'] ??
                                            false,
                                        onChanged: (value) {
                                          controller.pariwarjanmList[index]
                                              ['pramad'] = value;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            GestureDetector(
                onTap: () {
                  controller.index.value += 1;
                },
                child: btn()),
          ],
        ),
      ),
    );
  }
}
