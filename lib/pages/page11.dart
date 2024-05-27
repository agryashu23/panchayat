import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page11 extends StatefulWidget {
  const Page11({super.key});

  @override
  State<Page11> createState() => _Page11State();
}

class _Page11State extends State<Page11> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("24. चापाकल या नल की पानी की व्यवस्था?", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.handpump.value,
                    onChanged: (value) {
                      controller.handpump.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.handpump.value,
                    onChanged: (value) {
                      controller.handpump.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.03,
              ),
              Text("सोख्ता निर्मित किया जा सकता है या नहीं?",
                  style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.handpumpreason.value,
                    onChanged: (value) {
                      controller.handpumpreason.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.handpumpreason.value,
                    onChanged: (value) {
                      controller.handpumpreason.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    controller.index.value += 1;
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
