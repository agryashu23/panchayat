import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page9 extends StatefulWidget {
  const Page9({super.key});

  @override
  State<Page9> createState() => _Page9State();
}

class _Page9State extends State<Page9> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("22. शौचालय बनने की स्थिति?", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.toilet.value,
                    onChanged: (value) {
                      controller.toilet.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.toilet.value,
                    onChanged: (value) {
                      controller.toilet.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("यदि हां तो लाभ मिला या नहीं?", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.toiletbenefit.value,
                    onChanged: (value) {
                      controller.toiletbenefit.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.toiletbenefit.value,
                    onChanged: (value) {
                      controller.toiletbenefit.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("नहीं मिलने का कारण", style: styleText()),
              textField(
                  controller.toiletreason, TextInputType.text, getW(context)),
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
