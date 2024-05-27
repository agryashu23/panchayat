import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page10 extends StatefulWidget {
  const Page10({super.key});

  @override
  State<Page10> createState() => _Page10State();
}

class _Page10State extends State<Page10> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("23. परिवार में पेयजल योजना अंतर्गत नल लगा या नहीं?",
                  style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.water.value,
                    onChanged: (value) {
                      controller.water.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.water.value,
                    onChanged: (value) {
                      controller.water.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("टिप्पणी", style: styleText()),
              textField(
                  controller.watertippadi, TextInputType.text, getW(context)),
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
