import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page21 extends StatelessWidget {
  Page21({super.key});

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
                  "20. परिवार में 18 से अधिक उम्र के सदस्य जिनका नाम मतदाता सूची में नहीं है?",
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
                  initialValue: controller.above18.value,
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
                    controller.above18.value = value;
                    controller.initializeabove18List(
                        int.tryParse(controller.above18.value) ?? 0);
                  },
                ),
              ),
            ),
            controller.above18List.isNotEmpty
                ? SizedBox(
                    height: getH(context) * 0.3,
                    child: ListView.builder(
                      itemCount: int.tryParse(controller.above18.value),
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
                                    controller.above18List[index]['name'] ?? '',
                                    TextInputType.name,
                                    MediaQuery.of(context).size.width * 0.5,
                                    "नाम",
                                    (value) {
                                      controller.above18List[index]['name'] =
                                          value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 4,
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
