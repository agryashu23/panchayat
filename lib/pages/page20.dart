import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page20 extends StatefulWidget {
  const Page20({super.key});

  @override
  State<Page20> createState() => _Page20State();
}

class _Page20State extends State<Page20> {
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
                  "18. पिछले 2 वर्षों में परिवार के किसी सदस्य का मृत्यु हुआ है?",
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
                  initialValue: controller.pariwarmratyu.value,
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
                    controller.pariwarmratyu.value = value;
                    controller.initializevpariwarmratyuList(
                        int.tryParse(controller.pariwarmratyu.value) ?? 0);
                  },
                ),
              ),
            ),
            controller.pariwarmratyuList.isNotEmpty
                ? SizedBox(
                    height: getH(context) * 0.3,
                    child: ListView.builder(
                      itemCount: int.tryParse(controller.pariwarmratyu.value),
                      padding: const EdgeInsets.only(top: 16.0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
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
                                      controller.pariwarmratyuList[index]
                                              ['name'] ??
                                          '',
                                      TextInputType.name,
                                      MediaQuery.of(context).size.width * 0.35,
                                      "नाम",
                                      (value) {
                                        controller.pariwarmratyuList[index]
                                            ['name'] = value;
                                      },
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
                                        value:
                                            controller.pariwarmratyuList[index]
                                                    ['pramad'] ??
                                                false,
                                        onChanged: (value) {
                                          controller.pariwarmratyuList[index]
                                              ['pramad'] = value;
                                          setState(() {});
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
                                      const Text(
                                          "कबीर अंत्येष्टि योजना का लाभ?"),
                                      Switch(
                                        value:
                                            controller.pariwarmratyuList[index]
                                                    ['kabir'] ??
                                                false,
                                        onChanged: (value) {
                                          controller.pariwarmratyuList[index]
                                              ['kabir'] = value;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                textField2(
                                  controller.pariwarmratyuList[index]
                                          ['remark'] ??
                                      '',
                                  TextInputType.name,
                                  MediaQuery.of(context).size.width * 0.3,
                                  "टिप्पणी",
                                  (value) {
                                    controller.pariwarmratyuList[index]
                                        ['remark'] = value;
                                  },
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
                  controller.index.value += 1;
                },
                child: btn()),
          ],
        ),
      ),
    );
  }
}
