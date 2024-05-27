import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/controller.dart';
import 'package:survey/utils/utils.dart';
import 'package:survey/widgets/widget.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  File? image2;
  String urlImage = "";

  final HomeController controller = Get.find<HomeController>();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        image2 = imageTemp;
        controller.image2 = image2;
        urlImage = image2!.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getH(context) * 0.08,
              ),
              Text("1. मुखिया की तस्वीर", style: styleText()),
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('गैलरी से चयन'),
                              onTap: () async {
                                await pickImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('फोटो खीचे'),
                              onTap: () async {
                                await pickImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.02),
                    child: image2 != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(image2!), radius: 45)
                        : controller.urlImage.value != ""
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(controller.urlImage.value),
                                radius: 45)
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 45,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ))),
              ),
              SizedBox(
                height: getH(context) * 0.03,
              ),
              Text("2. परिवार के मुखिया का नाम", style: styleText()),
              textField(
                  controller.mukhiyaName, TextInputType.name, getW(context)),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("3. परिवार के मुखिया का मतदाता न.", style: styleText()),
              textField(
                  controller.mukhiyavoter, TextInputType.text, getW(context)),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("4. परिवार के मुखिया का आधार न.", style: styleText()),
              textField(controller.mukhiyaadhaar, TextInputType.number,
                  getW(context)),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("5. परिवार के मुखिया का राशन नं.", style: styleText()),
              textField(controller.mukhiyaration, TextInputType.number,
                  getW(context)),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Text("6. परिवार के मुखिया का मोबाइल नंबर.", style: styleText()),
              textField(controller.mukhiyanumber, TextInputType.number,
                  getW(context)),
              Text("7. परिवार के मुखिया का खाता संख्या.", style: styleText()),
              textField(controller.mukhiyaAccountNo, TextInputType.number,
                  getW(context)),
              Text("8. परिवार के मुखिया का आईएफएससी कोड.", style: styleText()),
              textField(
                  controller.mukhiyaifsc, TextInputType.text, getW(context)),
              Text("9. परिवार के मुखिया का बैंक नाम", style: styleText()),
              textField(controller.mukhiyaAccountName, TextInputType.text,
                  getW(context)),
              Text("10. परिवार को जॉब कार्ड प्राप्त है?", style: styleText()),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'हाँ',
                    groupValue: controller.jobCard.value,
                    onChanged: (value) {
                      controller.jobCard.value = value!;
                    },
                  ),
                  const Text('हाँ'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'नहीं',
                    groupValue: controller.jobCard.value,
                    onChanged: (value) {
                      controller.jobCard.value = value!;
                    },
                  ),
                  const Text('नहीं'),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Obx(
                () => controller.jobCard.value == "हाँ"
                    ? Column(
                        children: [
                          Text("संख्या", style: styleText()),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: SizedBox(
                              width: getW(context),
                              child: TextFormField(
                                initialValue: controller.jobCount.value,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                                onChanged: (value) {
                                  controller.jobCount.value = value;
                                  controller.initializejobList(
                                      int.tryParse(value) ?? 0);
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(
                height: 8,
              ),
              controller.jobCount.value.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: getH(context) * 0.15,
                      child: ListView.builder(
                          itemCount: int.tryParse(controller.jobCount.value),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${index + 1}."),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  textField2(
                                    controller.jobList[index]['name'] ?? '',
                                    TextInputType.name,
                                    getW(context) * 0.3,
                                    "नाम",
                                    (value) {
                                      controller.jobList[index]['name'] = value;
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  textField2(
                                    controller.jobList[index]['number'] ?? '',
                                    TextInputType.name,
                                    getW(context) * 0.4,
                                    "निबन्धन संख्या",
                                    (value) {
                                      controller.jobList[index]['number'] =
                                          value;
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 4,
              ),
              Obx(
                () => Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("परिवार में राशन कार्ड से वंचित सदस्य?",
                            style: styleText()),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: SizedBox(
                            width: getW(context),
                            child: TextFormField(
                              initialValue: controller.vanchit.value,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              onChanged: (value) {
                                controller.vanchit.value = value;
                                controller.initializevanchitList(
                                    int.tryParse(value) ?? 0);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        controller.vanchitList.isNotEmpty
                            ? SizedBox(
                                height: getH(context) * 0.3,
                                child: ListView.builder(
                                  itemCount: controller.vanchitList.length,
                                  padding: EdgeInsets.only(
                                      top: getH(context) * 0.04),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: getH(context) * 0.02,
                                          left: getW(context) * 0.15,
                                          right: getW(context) * 0.15),
                                      child: textField2(
                                        controller.vanchitList[index]['name'] ??
                                            '',
                                        TextInputType.name,
                                        getW(context) * 0.28,
                                        "नाम",
                                        (value) {
                                          controller.vanchitList[index]
                                              ['name'] = value;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (controller.mukhiyaName.isEmpty ||
                        controller.mukhiyaadhaar.isEmpty) {
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
