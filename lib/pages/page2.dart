import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page2 extends StatelessWidget {
  Page2({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("11. परिवार में कुल सदस्य", style: styleText()),
          textField(
              controller.people, TextInputType.number, getW(context) * 0.9),
          SizedBox(
            height: getH(context) * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                Text("पुरुष", style: styleText()),
                textField(
                    controller.male, TextInputType.number, getW(context) * 0.3)
              ]),
              Column(children: [
                Text("महिला", style: styleText()),
                textField(controller.female, TextInputType.number,
                    getW(context) * 0.3)
              ]),
            ],
          ),
          GestureDetector(
              onTap: () {
                if (controller.people.isEmpty ||
                    controller.male.isEmpty ||
                    controller.female.isEmpty) {
                  snackbar(context);
                } else {
                  controller.index.value += 1;
                }
              },
              child: btn())
        ],
      ),
    );
  }
}
