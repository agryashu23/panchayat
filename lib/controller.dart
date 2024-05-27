import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:random_string/random_string.dart';
import 'package:image/image.dart' as img;

class HomeController extends GetxController {
  var isEdit = false.obs;
  var pass = "".obs;

  var index = 0.obs;
  bool loading = false;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  var urlImage = "".obs;
  TextEditingController others = TextEditingController();

  var isLoading = false.obs;

  var mukhiyaName = "".obs;
  var mukhiyavoter = "".obs;
  var mukhiyaadhaar = "".obs;
  var mukhiyaration = "".obs;
  var mukhiyanumber = "".obs;
  var mukhiyaAccountNo = "".obs;
  var mukhiyaifsc = "".obs;
  var mukhiyaAccountName = "".obs;
  var jobCard = "नहीं".obs;
  var jobCount = "".obs;
  var jobList = [].obs;
  var people = "".obs;
  var male = "".obs;
  var female = "".obs;
  var kisanyojna = "नहीं".obs;
  var dataList = [].obs;
  var vanchit = "".obs;
  var vanchitList = [].obs;
  // var paariwarikyojna = "नहीं".obs;
  // var kabir = "नहीं".obs;
  var year60count = "".obs;
  var year60List = [].obs;
  var girlmarriage = "".obs;
  var girlmarriageList = [].obs;
  var vidhwa = "".obs;
  var vidhwaList = [].obs;
  var viklancount = "".obs;
  var vikalnkpeople = [].obs;
  var pariwarjanm = "".obs;
  var pariwarjanmList = [].obs;
  var pariwarmratyu = "".obs;
  var pariwarmratyuList = [].obs;
  var anankit = "".obs;
  var anankitList = [].obs;
  var above18 = "".obs;
  var above18List = [].obs;
  var pradhanyojna = "नहीं".obs;
  var pradhantippadi = "".obs;
  var awascomplete = "नहीं".obs;
  var awascompletetippadi = "".obs;
  var awasmajdoori = "नहीं".obs;
  var awasmajdooritippadi = "".obs;
  var toilet = "नहीं".obs;
  var toiletbenefit = "नहीं".obs;
  var toiletreason = "".obs;
  var water = "नहीं".obs;
  var watertippadi = "".obs;
  var handpump = "नहीं".obs;
  var handpumpreason = "नहीं".obs;
  var swachhta = "नहीं".obs;
  var swachhtareson = "".obs;
  var swachhtakarmi = "नहीं".obs;
  var rationpariwar = "".obs;
  var rationPariwarList = [].obs;
  File? image2;
  var ward = "".obs;

  var userId = "".obs;
  var password = "".obs;
  var isOwner = false.obs;
  var docId = "".obs;

  void initializeDataList(int count) {
    dataList.clear();
    for (int i = 0; i < count; i++) {
      dataList.add({
        'name': '',
        'age': '',
        'adhaar': '',
        'mobile': '',
        'account': '',
        'ifsc': '',
        'accountName': ''
      });
    }
  }

  void initializeviklankList(int count) {
    vikalnkpeople.clear();
    for (int i = 0; i < count; i++) {
      vikalnkpeople.add({'name': '', 'pramad': false, 'pension': false});
    }
  }

  void initializevpariwarjanmList(int count) {
    pariwarjanmList.clear();
    for (int i = 0; i < count; i++) {
      pariwarjanmList.add({'name': '', 'gender': false, 'pramad': false});
    }
  }

  void initializevanankitList(int count) {
    anankitList.clear();
    for (int i = 0; i < count; i++) {
      anankitList.add({'name': '', 'gender': false, 'age': ''});
    }
  }

  void initializevpariwarmratyuList(int count) {
    pariwarmratyuList.clear();
    for (int i = 0; i < count; i++) {
      pariwarmratyuList.add({
        'name': '',
        'pramad': false,
        'kabir': false,
        'laabh': false,
        'remark': ''
      });
    }
  }

  void initializevidhwaList(int count) {
    vidhwaList.clear();
    for (int i = 0; i < count; i++) {
      vidhwaList.add({'name': '', 'pension': false});
    }
  }

  void initializevanchitList(int count) {
    vanchitList.clear();
    for (int i = 0; i < count; i++) {
      vanchitList.add({'name': ''});
    }
  }

  void initializegirlmarriageList(int count) {
    girlmarriageList.clear();
    for (int i = 0; i < count; i++) {
      girlmarriageList.add({'name': '', 'yojna': false});
    }
  }

  void initializeyear60List(int count) {
    year60List.clear();
    for (int i = 0; i < count; i++) {
      year60List.add({'name': '', 'pension': false});
    }
  }

  void initializejobList(int count) {
    jobList.clear();
    for (int i = 0; i < count; i++) {
      jobList.add({'name': '', 'number': ''});
    }
  }

  void initializeabove18List(int count) {
    above18List.clear();
    for (int i = 0; i < count; i++) {
      above18List.add({'name': ''});
    }
  }

  void initializeRationPariwarList(int count) {
    rationPariwarList.clear();
    for (int i = 0; i < count; i++) {
      rationPariwarList.add({'name': ''});
    }
  }

  // List<String> splitAnswer(String answer) {
  //   List<String> parts = answer.split(',');
  //   return [
  //     parts.isNotEmpty ? parts[0] : '',
  //     parts.length > 1 ? parts[1] : '',
  //     parts.length > 2 ? parts[2] : '',
  //   ];
  // }

  Future<void> getData(String id) async {
    await FirebaseFirestore.instance
        .collection('details')
        .doc(id)
        .get()
        .then((value) {
      mukhiyaName.value = value['name'];
      urlImage.value = value['image'];
      mukhiyaadhaar.value = value['adhaar'];
      mukhiyaration.value = value['ration'];
      userId.value = value['userId'];
      mukhiyanumber.value = value['phone'];
      mukhiyaAccountNo.value = value['account'];
      kisanyojna.value = value['kisan'];
      vanchit.value = value['vanchit'];
      vanchitList.value = value['vanchitList'];
      mukhiyaifsc.value = value['ifsc'];
      mukhiyaAccountName.value = value['account_name'];
      jobCard.value = value['jobCard'];
      jobCount.value = value['jobCount'] ?? "";
      jobList.value = value['jobList'];
      people.value = value['people'];
      male.value = value['male'];
      female.value = value['female'];
      dataList.value = value['list'];
      year60count.value = value['questions'][0]['count'];
      year60List.value = value['questions'][0]['answer'];
      girlmarriage.value = value['questions'][1]['count'];
      girlmarriageList.value = value['questions'][1]['answer'];
      vidhwa.value = value['questions'][2]['count'];
      vidhwaList.value = value['questions'][2]['answer'];
      viklancount.value = value['questions'][3]['count'];
      vikalnkpeople.value = value['questions'][3]['answer'];
      pariwarjanm.value = value['questions'][4]['count'];
      pariwarjanmList.value = value['questions'][4]['answer'];
      pariwarmratyu.value = value['questions'][5]['count'];
      pariwarmratyuList.value = value['questions'][5]['answer'];
      anankit.value = value['questions'][6]['count'];
      anankitList.value = value['questions'][6]['answer'];
      above18.value = value['questions'][7]['count'];
      above18List.value = value['questions'][7]['answer'];
      pradhanyojna.value = value['questions'][8]['count'];
      pradhantippadi.value = value['questions'][8]['answer'];
      awascomplete.value = value['questions'][9]['count'];
      awascompletetippadi.value = value['questions'][9]['answer'];
      awasmajdoori.value = value['questions'][10]['answer'];
      awasmajdooritippadi.value = value['questions'][10]['answer'];
      toilet.value = value['questions'][11]['count'];
      toiletbenefit.value = value['questions'][12]['count'];
      toiletreason.value = value['questions'][13]['count'];
      water.value = value['questions'][14]['count'];
      watertippadi.value = value['questions'][14]['answer'];
      handpump.value = value['questions'][15]['count'];
      handpumpreason.value = value['questions'][15]['answer'];
      swachhta.value = value['questions'][16]['count'];
      swachhtareson.value = value['questions'][16]['answer'];
      swachhtakarmi.value = value['questions'][17]['count'];
      rationpariwar.value = value['questions'][18]['count'];
      rationPariwarList.value = value['questions'][18]['answer'];
      userId.value = value['userId'];
      ward.value = value['ward'];
      others.text = value['others'];
    });
  }

  Future<void> clearAllData() async {
    mukhiyaName.value = '';
    mukhiyaadhaar.value = '';
    mukhiyaration.value = '';
    mukhiyanumber.value = '';
    mukhiyaAccountName.value = '';
    mukhiyaAccountNo.value = '';
    mukhiyaifsc.value = '';
    kisanyojna.value = '';
    vanchitList.clear();
    vanchit.value = "";
    jobCard.value = "";
    jobCount.value = "";
    jobList.clear();
    isOwner.value = false;
    male.value = '';
    female.value = '';
    urlImage.value = '';
    people.value = '';
    userId.value = '';
    viklancount.value = '';
    ward.value = '';
    vikalnkpeople.clear();
    dataList.clear();
    year60count.value = '';
    year60List.clear();
    girlmarriage.value = '';
    vidhwa.value = '';
    vidhwaList.clear();
    pariwarjanm.value = "";
    pariwarjanmList.clear();
    pariwarmratyu.value = "";
    pariwarmratyuList.clear();
    anankit.value = '';
    above18.value = "";
    above18List.clear();
    anankitList.clear();
    pradhanyojna.value = '';
    awascomplete.value = '';
    awascompletetippadi.value = "";
    awasmajdoori.value = '';
    awasmajdooritippadi.value = "";
    toilet.value = '';
    toiletbenefit.value = '';
    toiletreason.value = '';
    water.value = '';
    watertippadi.value = '';
    handpump.value = '';
    handpumpreason.value = '';
    swachhta.value = '';
    swachhtareson.value = '';
    swachhtakarmi.value = '';
    rationpariwar.value = '';
    rationPariwarList.clear();
    others.clear();
  }

  Future<void> saveSurvey() async {
    isLoading.value = true;
    await FirebaseFirestore.instance.collection("details").add({
      "name": mukhiyaName.value,
      "serial": "ward${ward.value}${randomAlphaNumeric(5)}",
      "image": urlImage.value,
      "ward": ward.value,
      "userId": userId.value,
      "voter": mukhiyavoter.value,
      "vanchit": vanchit.value,
      "vanchitList": vanchitList,
      "ration": mukhiyaration.value,
      "adhaar": mukhiyaadhaar.value,
      "phone": mukhiyanumber.value,
      "account": mukhiyaAccountNo.value,
      "ifsc": mukhiyaifsc.value,
      "account_name": mukhiyaAccountName.value,
      "jobCard": jobCard.value,
      "jobList": jobList,
      "kisan": kisanyojna.value,
      "jobCount": jobCount.value,
      "people": people.value,
      "male": male.value,
      "female": female.value,
      "list": dataList,
      "others": others.text,
      "questions": <Map<String, dynamic>>[
        {
          'count': year60count.value,
          'answer': year60List,
          'question': 'परिवार में 60 वर्षा से अधिक उम्र वाले सदस्यों की संख्या?'
        },
        {
          'answer': girlmarriageList,
          'count': girlmarriage.value,
          'question': 'पिछले 2 वर्ष में लड़की की शादी हुई?'
        },
        {
          'answer': vidhwaList,
          'count': vidhwa.value,
          'question': 'परिवार में विधवा सदस्यों की संख्या?'
        },
        {
          'answer': vikalnkpeople,
          'count': viklancount.value,
          'question': 'परिवार में विकलांग सदस्यों की संख्या?'
        },
        {
          'answer': pariwarjanmList,
          'count': pariwarjanm.value,
          'question': 'पिछले 2 वर्षों में परिवार के किसी सदस्य का जन्म हुआ है?'
        },
        {
          'answer': pariwarmratyuList,
          'count': pariwarmratyu.value,
          'question':
              'पिछले 2 वर्षों में परिवार के किसी सदस्य का मृत्यु हुआ है?'
        },
        {
          'answer': anankitList,
          "count": anankit.value,
          'question': 'परिवार में अनामांकित बच्चे(वर्ष 06 -14) की संख्या?'
        },
        {
          'answer': above18List,
          "count": above18.value,
          'question':
              'परिवार में 18 से अधिक उम्र क सदस्य जिनका नाम मतदाता सूची में नहीं है?'
        },
        {
          'answer': pradhantippadi.value,
          'count': pradhanyojna.value,
          'question': 'प्रधानमंत्री आवास प्राप्त हुआ?'
        },
        {
          'answer': awascompletetippadi.value,
          'count': awascomplete.value,
          'question': 'यदि हां तो आवास पूरा हुआ?'
        },
        {
          'answer': awasmajdooritippadi.value,
          'count': awasmajdoori.value,
          'question': 'आवास का मजदूरी प्राप्त की स्तिथि?'
        },
        {'count': toilet.value, 'question': 'शौचालय बनने की स्तिथि?'},
        {
          'count': toiletbenefit.value,
          'question': 'यदि हां तो लाभ मिला या नहीं?'
        },
        {'count': toiletreason.value, 'question': 'नहीं मिलने का कारण?'},
        {
          'count': water.value,
          'answer': watertippadi.value,
          'question': 'परिवार में पेयजल योजना अंतर्गत नल लगा या नहीं?'
        },
        {
          'count': handpump.value,
          'answer': handpumpreason.value,
          'question': 'चापाकल या नल की पानी की व्यवस्था?'
        },
        {
          'count': swachhta.value,
          'answer': swachhtareson.value,
          'question': 'स्वछ्ता शुल्क भुकतान किया गया है या नहीं?'
        },
        {
          'count': swachhtakarmi.value,
          'question': 'स्वच्छता कर्मी प्रतिदिन आता है या नहीं?'
        },
        {
          'count': rationpariwar.value,
          'answer': rationPariwarList,
          'question': 'परिवार में राशन कार्ड से वंचित सदस्य?'
        },
      ],
    });
    isLoading.value = false;
  }

  Future<void> updateSurvey() async {
    isLoading.value = true;

    await FirebaseFirestore.instance
        .collection("details")
        .doc(docId.value)
        .update({
      "name": mukhiyaName.value,
      "serial": "ward${ward.value}${randomAlphaNumeric(5)}",
      "image": urlImage.value,
      "ward": ward.value,
      "userId": userId.value,
      "voter": mukhiyavoter.value,
      "ration": mukhiyaration.value,
      "vanchit": vanchit.value,
      'vanchitList': vanchitList,
      "kisan": kisanyojna.value,
      "adhaar": mukhiyaadhaar.value,
      "phone": mukhiyanumber.value,
      "account": mukhiyaAccountNo.value,
      "ifsc": mukhiyaifsc.value,
      "account_name": mukhiyaAccountName.value,
      "jobCard": jobCard.value,
      "jobList": jobList,
      "people": people.value,
      "male": male.value,
      "female": female.value,
      "list": dataList,
      "others": others.value,
      "questions": <Map<String, dynamic>>[
        {
          'count': year60count.value,
          'answer': year60List,
          'question': 'परिवार में 60 वर्षा से अधिक उम्र वाले सदस्यों की संख्या?'
        },
        {
          'answer': girlmarriageList,
          'count': girlmarriage.value,
          'question': 'पिछले 2 वर्ष में लड़की की शादी हुई?'
        },
        {
          'answer': vidhwaList,
          'count': vidhwa.value,
          'question': 'परिवार में विधवा सदस्यों की संख्या?'
        },
        {
          'answer': vikalnkpeople,
          'count': viklancount.value,
          'question': 'परिवार में विकलांग सदस्यों की संख्या?'
        },
        {
          'answer': pariwarjanmList,
          'count': pariwarjanm.value,
          'question': 'पिछले 2 वर्षों में परिवार के किसी सदस्य का जन्म हुआ है?'
        },
        {
          'answer': pariwarmratyuList,
          'count': pariwarmratyu.value,
          'question':
              'पिछले 2 वर्षों में परिवार के किसी सदस्य का मृत्यु हुआ है?'
        },
        {
          'answer': anankitList,
          "count": anankit.value,
          'question': 'परिवार में अनंकित बच्चे(वर्ष 06 -14) की संख्या?'
        },
        {
          'answer': above18List,
          "count": above18.value,
          'question':
              'परिवार में 18 से अधिक उम्र क सदस्य जिनका नाम मतदाता सूची में नहीं है?'
        },
        {
          'answer': pradhantippadi.value,
          'count': pradhanyojna.value,
          'question': 'प्रधानमंत्री आवास प्राप्त हुआ?'
        },
        {
          'answer': awascompletetippadi.value,
          'count': awascomplete.value,
          'question': 'यदि हां तो आवास पूरा हुआ?'
        },
        {
          'answer': awasmajdooritippadi.value,
          'count': awasmajdoori.value,
          'question': 'आवास का मजदूरी प्राप्त की स्तिथि?'
        },
        {'count': toilet.value, 'question': 'शौचालय बनने की स्तिथि?'},
        {
          'count': toiletbenefit.value,
          'question': 'यदि हां तो लाभ मिला या नहीं?'
        },
        {'count': toiletreason.value, 'question': 'नहीं मिलने का कारण?'},
        {
          'count': water.value,
          'answer': watertippadi.value,
          'question': 'परिवार में पेयजल योजना अंतर्गत नल लगा या नहीं?'
        },
        {
          'count': handpump.value,
          'answer': handpumpreason.value,
          'question': 'चापाकल या नल की पानी की व्यवस्था?'
        },
        {
          'count': swachhta.value,
          'answer': swachhtareson.value,
          'question': 'स्वछ्ता शुल्क भुकतान किया गया है या नहीं?'
        },
        {
          'count': swachhtakarmi.value,
          'question': 'स्वच्छता कर्मी प्रतिदिन आता है या नहीं?'
        },
        {
          'count': rationpariwar.value,
          'answer': rationPariwarList,
          'question': 'परिवार में राशन कार्ड से वंचित सदस्य?'
        },
      ],
    });
    isLoading.value = false;
  }

  Future<void> uploadFiles() async {
    isLoading.value = true;

    if (image2 == null) {
      isLoading.value = false;
      return;
    }
    img.Image? image = img.decodeImage(image2!.readAsBytesSync());
    List<int> pngBytes = img.encodePng(image!);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(image2!.path)}.png');
    File pngFile = File(
        '${Path.dirname(image2!.path)}/${Path.basenameWithoutExtension(image2!.path)}.png');
    await pngFile.writeAsBytes(pngBytes);
    await ref.putFile(pngFile).whenComplete(() async {
      await ref.getDownloadURL().then((value) async {
        imgRef?.add({"url": value});
        urlImage.value = value;
      });
    });

    isLoading.value = false;
  }
}
