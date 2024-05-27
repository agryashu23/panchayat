import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page17 extends StatefulWidget {
  const Page17({super.key});

  @override
  State<Page17> createState() => _Page17State();
}

class _Page17State extends State<Page17> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("16. परिवार में विकलांग सदस्यों की संख्या?",
                  style: styleText()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: getW(context),
                  child: TextFormField(
                    initialValue: controller.viklancount.value,
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
                      controller.viklancount.value = value;
                      if (value != "0") {
                        controller
                            .initializeviklankList(int.tryParse(value) ?? 0);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              controller.vikalnkpeople.isNotEmpty
                  ? SizedBox(
                      height: getH(context) * 0.4,
                      child: ListView.builder(
                        itemCount: int.tryParse(controller.viklancount.value),
                        padding: const EdgeInsets.only(top: 16.0),
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${index + 1}."),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textField2(
                                        controller.vikalnkpeople[index]
                                                ['name'] ??
                                            '',
                                        TextInputType.name,
                                        MediaQuery.of(context).size.width * 0.4,
                                        "नाम",
                                        (value) {
                                          controller.vikalnkpeople[index]
                                              ['name'] = value;
                                        },
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        const Text("प्रमाण पत्र निर्गत"),
                                        Switch(
                                          value: controller.vikalnkpeople[index]
                                                  ['pramad'] ??
                                              false,
                                          onChanged: (value) {
                                            controller.vikalnkpeople[index]
                                                ['pramad'] = value;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        const Text("विकलांक पेंशन का लाभ"),
                                        Switch(
                                          value: controller.vikalnkpeople[index]
                                                  ['pension'] ??
                                              false,
                                          onChanged: (value) {
                                            controller.vikalnkpeople[index]
                                                ['pension'] = value;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
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
                    if (controller.viklancount.isEmpty) {
                      snackbar(context);
                    } else {
                      controller.index.value += 1;
                    }
                  },
                  child: btn()),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
