import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page8 extends StatefulWidget {
  const Page8({super.key});

  @override
  State<Page8> createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("21. प्रधानमंत्री आवास प्राप्त हुआ या नहीं?",
                  style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.pradhanyojna.value,
                    onChanged: (value) {
                      controller.pradhanyojna.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.pradhanyojna.value,
                    onChanged: (value) {
                      controller.pradhanyojna.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              Obx(
                () => controller.pradhanyojna.value == "नहीं"
                    ? Column(
                        children: [
                          Text("टिप्पणी", style: styleText()),
                          textField(controller.pradhantippadi,
                              TextInputType.text, getW(context) * 0.6),
                        ],
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("यदि हां तो आवास पूरा हुआ?", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.awascomplete.value,
                    onChanged: (value) {
                      controller.awascomplete.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.awascomplete.value,
                    onChanged: (value) {
                      controller.awascomplete.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              Text("टिप्पणी", style: styleText()),
              textField(controller.awascompletetippadi, TextInputType.text,
                  getW(context) * 0.6),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("आवास का मजदूरी प्राप्त की स्तिथि", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.awasmajdoori.value,
                    onChanged: (value) {
                      controller.awasmajdoori.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.awasmajdoori.value,
                    onChanged: (value) {
                      controller.awasmajdoori.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("टिप्पणी", style: styleText()),
              textField(controller.awasmajdooritippadi, TextInputType.text,
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
