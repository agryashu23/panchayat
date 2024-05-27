import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
                  "13. परिवार में 60 वर्षों से अधिक उम्र वाले सदस्यों की संख्या?",
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
                  initialValue: controller.year60count.value,
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
                    controller.year60count.value = value;
                    controller.initializeyear60List(
                        int.tryParse(controller.year60count.value) ?? 0);
                  },
                ),
              ),
            ),
            controller.year60List.isNotEmpty
                ? SizedBox(
                    height: getH(context) * 0.3,
                    child: ListView.builder(
                      itemCount: int.tryParse(controller.year60count.value),
                      padding: const EdgeInsets.only(top: 16.0),
                      itemBuilder: (context, index) {
                        return Padding(
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
                                    controller.year60List[index]['name'] ?? '',
                                    TextInputType.name,
                                    MediaQuery.of(context).size.width * 0.5,
                                    "नाम",
                                    (value) {
                                      controller.year60List[index]['name'] =
                                          value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("पेंशन का लाभ"),
                                  Switch(
                                    value: controller.year60List[index]
                                            ['pension'] ??
                                        false,
                                    onChanged: (value) {
                                      controller.year60List[index]['pension'] =
                                          value;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
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
