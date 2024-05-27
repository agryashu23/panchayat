import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controller.dart';
import 'package:survey/homepage.dart';
import 'package:survey/utils/utils.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Page18 extends StatefulWidget {
  const Page18({super.key});

  @override
  State<Page18> createState() => _Page18State();
}

class _Page18State extends State<Page18> {
  final HomeController controller = Get.find<HomeController>();
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult, localeId: 'hi-IN');
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    controller.others.text = result.recognizedWords;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("30. अन्य समस्या?", style: styleText()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: SizedBox(
                      width: getW(context) * 0.9,
                      child: TextFormField(
                        controller: controller.others,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        maxLength: 500,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
                          controller.others.text = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () async {
                          if (controller.isOwner.value) {
                            await controller.uploadFiles();
                            await controller.updateSurvey();
                            AwesomeDialog(
                              context: context,
                              autoHide: const Duration(seconds: 2),
                              dialogType: DialogType.success,
                              dismissOnTouchOutside: true,
                              animType: AnimType.rightSlide,
                              title: 'सर्वे क लिए शुक्रिया',
                              onDismissCallback: (type) {
                                controller.index.value = 0;
                                controller.isOwner.value = false;
                                Navigator.pop(context);
                              },
                            ).show();
                          } else {
                            await controller.uploadFiles();
                            await controller.saveSurvey();
                            AwesomeDialog(
                              context: context,
                              autoHide: const Duration(seconds: 2),
                              dialogType: DialogType.success,
                              dismissOnTouchOutside: true,
                              animType: AnimType.rightSlide,
                              title: 'सर्वे देने क लिए शुक्रिया',
                              onDismissCallback: (type) {
                                controller.index.value = 0;
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                  (route) => false,
                                );
                              },
                            ).show();
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: 50,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("जमा करें",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.save,
                                  size: 20,
                                )
                              ],
                            ))),
                  ),
                  SizedBox(
                    height: getH(context) * 0.2,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (speechToText.isNotListening) {
                        _startListening();
                      } else {
                        _stopListening();
                      }
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(speechToText.isNotListening
                          ? Icons.mic_off
                          : Icons.mic),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
