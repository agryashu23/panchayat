import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page7 extends StatefulWidget {
  const Page7({super.key});

  @override
  State<Page7> createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: getH(context) * 0.03,
            ),
            Text("19. परिवार में अनामांकित बच्चे(वर्ष 06 -14) की संख्या?",
                style: styleText()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: getW(context),
                child: TextFormField(
                  initialValue: controller.anankit.value,
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
                    controller.anankit.value = value;
                    controller.initializevanankitList(
                        int.tryParse(controller.anankit.value) ?? 0);
                  },
                ),
              ),
            ),
            SizedBox(
              height: getH(context) * 0.02,
            ),
            controller.anankitList.isNotEmpty
                ? SizedBox(
                    height: getH(context) * 0.3,
                    child: ListView.builder(
                      itemCount: int.tryParse(controller.anankit.value),
                      padding: const EdgeInsets.only(top: 16.0),
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${index + 1}."),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textField2(
                                      controller.anankitList[index]['name'] ??
                                          '',
                                      TextInputType.name,
                                      MediaQuery.of(context).size.width * 0.4,
                                      "नाम",
                                      (value) {
                                        controller.anankitList[index]['name'] =
                                            value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                textField2(
                                  controller.anankitList[index]['age'] ?? '',
                                  TextInputType.number,
                                  MediaQuery.of(context).size.width * 0.2,
                                  "आयु",
                                  (value) {
                                    controller.anankitList[index]['age'] =
                                        value;
                                  },
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      const Text("पुरुष"),
                                      Radio<bool>(
                                        value: false,
                                        groupValue: controller
                                                .anankitList[index]['gender'] ??
                                            false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.anankitList[index]
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
                                        groupValue: controller
                                                .anankitList[index]['gender'] ??
                                            false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.anankitList[index]
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
                  if (controller.anankit.isEmpty) {
                    snackbar(context);
                  } else {
                    controller.index.value += 1;
                  }
                },
                child: btn()),
          ],
        ),
      ),
    );
  }
}
