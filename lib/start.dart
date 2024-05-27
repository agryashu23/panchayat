import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/owner_page.dart';
import 'package:survey/pages/page1.dart';
import 'package:survey/pages/page10.dart';
import 'package:survey/pages/page11.dart';
import 'package:survey/pages/page12.dart';
import 'package:survey/pages/page13.dart';
import 'package:survey/pages/page14.dart';
import 'package:survey/pages/page15.dart';
import 'package:survey/pages/page16.dart';
import 'package:survey/pages/page17.dart';
import 'package:survey/pages/page18.dart';
import 'package:survey/pages/page19.dart';
import 'package:survey/pages/page2.dart';
import 'package:survey/pages/page20.dart';
import 'package:survey/pages/page21.dart';
import 'package:survey/pages/page3.dart';
import 'package:survey/pages/page4.dart';
import 'package:survey/pages/page5.dart';
import 'package:survey/pages/page6.dart';
import 'package:survey/pages/page7.dart';
import 'package:survey/pages/page8.dart';
import 'package:survey/pages/page9.dart';
import 'package:survey/utils/utils.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final HomeController controller = Get.find<HomeController>();

  List<Widget> pages = [
    const Page1(),
    Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
    const Page6(),
    const Page17(),
    const Page15(),
    const Page20(),
    const Page7(),
    Page21(),
    const Page8(),
    const Page9(),
    const Page10(),
    const Page11(),
    const Page12(),
    Page13(),
    const Page14(),
    // Page16(),
    Page19(),
    const Page18(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                if (controller.index >= 1) {
                  controller.index -= 1;
                } else {
                  controller.isOwner.value = false;
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.arrow_back),
            ),
            actions: [
              controller.index.value == 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OwnerPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text("सर्वेक्षण संपादित"),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: () {
              if (controller.index >= 1) {
                controller.index -= 1;
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  width: getW(context),
                  height: getH(context),
                  fit: BoxFit.cover,
                ),
                pages[controller.index.value],
              ],
            ),
          )),
    );
  }
}
