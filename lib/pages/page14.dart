import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page14 extends StatefulWidget {
  const Page14({super.key});

  @override
  State<Page14> createState() => _Page14State();
}

class _Page14State extends State<Page14> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("27. परिवार में राशन कार्ड से वंचित सदस्य?",
                  style: styleText()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: getW(context),
                  child: TextFormField(
                    initialValue: controller.rationpariwar.value,
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
                      controller.rationpariwar.value = value;
                      controller.initializeRationPariwarList(
                          int.tryParse(value) ?? 0);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.rationPariwarList.isNotEmpty
                  ? SizedBox(
                      height: getH(context) * 0.3,
                      child: ListView.builder(
                        itemCount: controller.rationPariwarList.length,
                        padding: EdgeInsets.only(top: getH(context) * 0.04),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: getH(context) * 0.02,
                                left: getW(context) * 0.15,
                                right: getW(context) * 0.15),
                            child: textField2(
                              controller.rationPariwarList[index]['name'] ?? '',
                              TextInputType.name,
                              getW(context) * 0.28,
                              "नाम",
                              (value) {
                                controller.rationPariwarList[index]['name'] =
                                    value;
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              GestureDetector(
                  onTap: () {
                    if (controller.rationpariwar.isEmpty) {
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
