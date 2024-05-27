import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page19 extends StatelessWidget {
  Page19({super.key});

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
              child: Text("29. किसान सम्मान निधि योजना से लाभान्वित है?",
                  style: styleText()),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'हाँ',
                  groupValue: controller.kisanyojna.value,
                  onChanged: (value) {
                    controller.kisanyojna.value = value!;
                  },
                ),
                const Text('हाँ'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'नहीं',
                  groupValue: controller.kisanyojna.value,
                  onChanged: (value) {
                    controller.kisanyojna.value = value!;
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
