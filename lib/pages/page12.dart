import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page12 extends StatefulWidget {
  const Page12({super.key});

  @override
  State<Page12> createState() => _Page12State();
}

class _Page12State extends State<Page12> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("25. स्वछ्ता शुल्क भुगतान किया गया है या नहीं?",
                  style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.swachhta.value,
                    onChanged: (value) {
                      controller.swachhta.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.swachhta.value,
                    onChanged: (value) {
                      controller.swachhta.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("यदि हाँ तो कितने महीने का", style: styleText()),
              textField(controller.swachhtareson, TextInputType.number,
                  getW(context)),
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
