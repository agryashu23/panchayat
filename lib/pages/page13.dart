import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page13 extends StatelessWidget {
  Page13({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("26. स्वच्छता कर्मी प्रतिदिन आता है या नहीं?",
                style: styleText()),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'हाँ',
                  groupValue: controller.swachhtakarmi.value,
                  onChanged: (value) {
                    controller.swachhtakarmi.value = value!;
                  },
                ),
                const Text('हाँ'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'नहीं',
                  groupValue: controller.swachhtakarmi.value,
                  onChanged: (value) {
                    controller.swachhtakarmi.value = value!;
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
          ],
        ),
      ),
    );
  }
}
