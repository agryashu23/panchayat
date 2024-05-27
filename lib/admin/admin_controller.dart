import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:survey/utils/utils.dart';

class AdminController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var data = [].obs;

  var userId = "".obs;
  var userPass = "".obs;
  var userPhone = "".obs;
  var userWard = 1.obs;

  var selectedQuestion = ''.obs;
  var selectedAnswer = ''.obs;
  var selectedWard = ''.obs;

  void setQuestion(String question) {
    selectedQuestion.value = question;
  }

  void setAnswer(String answer) {
    selectedAnswer.value = answer;
  }

  void setWard(String ward) {
    selectedWard.value = ward;
  }

  List<Map<String, dynamic>> filterDocuments(QuerySnapshot snapshot) {
    if (selectedQuestion.value.isEmpty &&
        selectedAnswer.value.isEmpty &&
        selectedWard.value.isEmpty) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } else if (selectedWard.value.isNotEmpty &&
        selectedQuestion.value.isNotEmpty &&
        selectedAnswer.value.isNotEmpty) {
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .where((data) {
        if (data['questions'] == null ||
            data['questions'] is! List ||
            data['ward'] == null) {
          return false;
        }
        List<dynamic> questions = data['questions'];
        return questions.any((question) {
          if (question['question'] == null || question['answer'] == null) {
            return false;
          }
          var answers = question['answer'].split(',');
          return question['question'] == selectedQuestion.value &&
              answers.contains(selectedAnswer.value) &&
              data['ward'].toString() == selectedWard.value;
        });
      }).toList();
    } else if (selectedWard.value.isEmpty &&
        selectedQuestion.value.isNotEmpty &&
        selectedAnswer.value.isNotEmpty) {
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .where((data) {
        if (data['questions'] == null || data['questions'] is! List) {
          return false;
        }

        List<dynamic> questions = data['questions'];
        return questions.any((question) {
          if (question['question'] == null || question['answer'] == null) {
            return false;
          }
          var answers = question['answer'].split(',');
          print(question['question'] == selectedQuestion.value &&
              answers.contains(selectedAnswer.value));
          return question['question'] == selectedQuestion.value &&
              answers.contains(selectedAnswer.value);
        });
      }).toList();
    } else if (selectedWard.value.isNotEmpty &&
        (selectedQuestion.value.isEmpty || selectedAnswer.value.isEmpty)) {
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .where((data) {
        return data['ward'].toString() == selectedWard.value;
      }).toList();
    } else {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }
  }

  pw.Widget _buildDataListSection(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['list'] ?? []);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          pw.Text('12.', style: const pw.TextStyle(fontSize: 18)),
          pw.Text('सदस्य सूची', style: const pw.TextStyle(fontSize: 18)),
        ]),
        pw.Table.fromTextArray(
          headers: [
            'नाम',
            'आयु',
            'आधार नं.',
            'फ़ोन',
            'खाता नंबर',
            'ifsc',
            'खाता नाम'
          ],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) => [
                    item['name'],
                    item['age'],
                    item['adhaar'],
                    item['mobile'],
                    item['account'],
                    item['ifsc'],
                    item['accountName']
                  ])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildViklankListSection(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][3]['answer']);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', 'प्रमाण पत्र निर्गत', 'विकलांक पेंशन का लाभ'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) => [
                    item['name'],
                    item['pramad'] == true ? "हाँ" : "नहीं",
                    item['pension'] == true ? "हाँ" : "नहीं"
                  ])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildJanm(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][4]['answer']);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', "लिंग", 'प्रमाण पत्र निर्गत'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) => [
                    item['name'],
                    item['gender'] == true ? "महिला" : "पुरुष",
                    item['pramad'] == true ? "हाँ" : "नहीं"
                  ])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildAnankit(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][6]['answer']);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', "लिंग", 'आयु'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) => [
                    item['name'],
                    item['gender'] == true ? "महिला" : "पुरुष",
                    item['age']
                  ])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildMratyu(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][5]['answer']);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: [
            'नाम',
            'प्रमाण पत्र निर्गत',
            "कबीर अंत्येष्टि",
            "पारिवारिक लाभ"
          ],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) => [
                    item['name'],
                    item['pramad'] == true ? "हाँ" : "नहीं",
                    item['kabir'] == true ? "हाँ" : "नहीं",
                    item['laabh'] == true ? "हाँ" : "नहीं"
                  ])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildYear60Section(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][0]['answer']);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', 'पेंशन'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) =>
                  [item['name'], item['pension'] == true ? "हाँ" : "नहीं"])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildGirlMarriage(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][1]['answer']);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', 'कन्या विवाह योजना'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) =>
                  [item['name'], item['yojna'] == true ? "हाँ" : "नहीं"])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildVidhwa(Map<String, dynamic> data) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(data['questions'][2]['answer']);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', 'विधवा पेंशन का लाभ'],
          data: dataList
              .where((item) => item['name'] != null && item['name'].isNotEmpty)
              .map((item) =>
                  [item['name'], item['pension'] == true ? "हाँ" : "नहीं"])
              .toList(),
        ),
      ],
    );
  }

  pw.Widget _buildabove18(Map<String, dynamic> data) {
    List<dynamic> rawJobList = data['questions'][7]['answer'] is List
        ? data['questions'][7]['answer']
        : [];
    List<Map<String, dynamic>> peopleList = [];
    for (var item in rawJobList) {
      if (item is Map<String, dynamic> &&
          item['name'] != null &&
          item['name'].isNotEmpty) {
        peopleList.add({'name': item['name']});
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम'],
          data: peopleList.map((item) => [item['name']]).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildJobSection(Map<String, dynamic> data) {
    List<dynamic> rawJobList = data['jobList'] is List ? data['jobList'] : [];
    List<Map<String, dynamic>> peopleList = [];
    for (var item in rawJobList) {
      if (item is Map<String, dynamic> &&
          item['name'] != null &&
          item['name'].isNotEmpty) {
        peopleList.add({'name': item['name'], 'number': item['number']});
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम', 'निबन्धन संख्या'],
          data:
              peopleList.map((item) => [item['name'], item['number']]).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildVanchitSection(Map<String, dynamic> data) {
    List<dynamic> rawJobList =
        data['vanchitList'] is List ? data['vanchitList'] : [];
    List<Map<String, dynamic>> peopleList = [];
    for (var item in rawJobList) {
      if (item is Map<String, dynamic> &&
          item['name'] != null &&
          item['name'].isNotEmpty) {
        peopleList.add({'name': item['name']});
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम'],
          data: peopleList.map((item) => [item['name']]).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildRationListSection(Map<String, dynamic> data) {
    // Check if 'answer' is a List, if not, default to an empty list
    List<dynamic> answerList = data['questions'][18]['answer'] is List
        ? data['questions'][18]['answer']
        : [];
    List<Map<String, dynamic>> peopleList = [];

    // Iterate through each item in the list
    for (var item in answerList) {
      if (item is Map<String, dynamic> &&
          item['name'] != null &&
          item['name'].isNotEmpty) {
        peopleList.add({'name': item['name']});
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table.fromTextArray(
          headers: ['नाम'],
          data: peopleList.map((item) => [item['name']]).toList(),
        ),
      ],
    );
  }

  Future<Future<Uint8List>> generatePdf(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/Hind-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);
    final image = data['image'] != ""
        ? pw.MemoryImage(
            (await NetworkAssetBundle(Uri.parse(data['image'])).load(''))
                .buffer
                .asUint8List(),
          )
        : null;

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttf),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('पंचायत सर्वेक्षण',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 24)),
          ),
          image != null
              ? pw.Center(
                  child: pw.ClipRRect(
                  horizontalRadius: 20,
                  verticalRadius: 20,
                  child: pw.Image(image,
                      width: 110, height: 80, fit: pw.BoxFit.cover),
                ))
              : pw.SizedBox(),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Serial No.'),
              pw.Text(data['serial'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('कार्यकर्ता'),
              pw.Text(data['userId'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('वार्ड क्रमांक'),
              pw.Text(data['ward'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('1.परिवार के मुखिया का नाम'),
              pw.Text(data['name'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('2.परिवार के मुखिया का मतदाता न.'),
              pw.Text(data['voter'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('3.परिवार के मुखिया का आधार न.'),
              pw.Text(data['adhaar'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('4.परिवार के मुखिया का राशन नं.'),
              pw.Text(data['ration'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("6. परिवार के मुखिया का मोबाइल नंबर."),
              pw.Text(data['phone'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("7. परिवार के मुखिया का खाता संख्या."),
              pw.Text(data['account'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("8. परिवार के मुखिया का आईएफएससी कोड."),
              pw.Text(data['ifsc'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("9. परिवार के मुखिया का बैंक नाम"),
              pw.Text(data['account_name'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("10. परिवार को जॉब कार्ड प्राप्त है?"),
              pw.Text(data['jobCard'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("संख्या"),
              pw.Text(data['jobCount'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 8),
          _buildJobSection(data),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("जॉब कार्ड से वंचित सदस्य?"),
              pw.Text(data['vanchit'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 8),
          _buildVanchitSection(data),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("11. परिवार में कुल सदस्य"),
              pw.Text(data['people'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('पुरुष'),
              pw.Text(data['male'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('महिला'),
              pw.Text(data['female'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 8),
          _buildDataListSection(data),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                  '13. परिवार में 60 वर्षा से अधिक उम्र वाले सदस्यों की संख्या?'),
              pw.Text(data['questions'][0]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildYear60Section(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("14. पिछले 2 वर्ष में लड़की की शादी हुई?"),
              pw.Text(data['questions'][1]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildGirlMarriage(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("15. परिवार में विधवा सदस्यों की संख्या?"),
              pw.Text(data['questions'][2]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildVidhwa(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("16. परिवार में विकलांग सदस्यों की संख्या?"),
              pw.Text(data['questions'][3]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildViklankListSection(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                  "17. पिछले 2 वर्षों में परिवार के किसी सदस्य का जन्म हुआ है?"),
              pw.Text(data['questions'][4]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildJanm(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "18. पिछले 2 वर्षों में परिवार के किसी सदस्य का मृत्यु हुआ है?",
              ),
              pw.Text(data['questions'][5]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildMratyu(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "19. परिवार में अनामांकित बच्चे(वर्ष 06 -14) की संख्या?",
              ),
              pw.Text(data['questions'][6]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildAnankit(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "20. परिवार में 18 से अधिक उम्र क सदस्य जिनका नाम मतदाता सूची में नहीं है?",
              ),
              pw.Text(data['questions'][7]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          _buildabove18(data),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "21. प्रधानमंत्री आवास प्राप्त हुआ या नहीं?",
              ),
              pw.Text(data['questions'][8]['count'] ?? ''),
            ],
          ),
          pw.Text(data['questions'][8]['answer'] ?? ''),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('यदि हां तो आवास पूरा हुआ?'),
              pw.Text(data['questions'][9]['count'] ?? ''),
            ],
          ),
          pw.Text(data['questions'][9]['answer'] ?? ''),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('आवास का मजदूरी प्राप्त की स्तिथि'),
              pw.Text(data['questions'][10]['count'] ?? ''),
            ],
          ),
          pw.Text(data['questions'][10]['answer'] ?? ''),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("22. शौचालय बनने की स्तिथि?"),
              pw.Text(data['questions'][11]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("यदि हां तो लाभ मिला या नहीं?"),
              pw.Text(data['questions'][12]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("नहीं मिलने का कारण"),
              pw.Text(data['questions'][13]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "23. परिवार में पेयजल योजना अंतर्गत नल लगा या नहीं?",
              ),
              pw.Text(data['questions'][14]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "टिप्पणी",
              ),
              pw.Text(data['questions'][14]['answer'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("24. चापाकल या नल की पानी की व्यवस्था?"),
              pw.Text(data['questions'][15]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("सोख्ता निर्मित किया जा सकता है या नहीं?"),
              pw.Text(data['questions'][15]['answer'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "25. स्वछ्ता शुल्क भुकतान किया गया है या नहीं?",
              ),
              pw.Text(data['questions'][16]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("यदि हाँ तो कितने महीने का"),
              pw.Text(data['questions'][16]['answer'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "26. स्वच्छता कर्मी प्रतिदिन आता है या नहीं?",
              ),
              pw.Text(data['questions'][17]['count'] ?? ''),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "27. परिवार में राशन कार्ड से वंचित सदस्य?",
              ),
              pw.Text(data['questions'][18]['count'] ?? ''),
            ],
          ),
          pw.SizedBox(height: 8),
          _buildRationListSection(data),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "28. किसान सम्मान निधि योजना से लाभान्वित है?",
              ),
              pw.Text(data['kisan'] ?? ''),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "29. अन्य समस्या?",
              ),
              pw.Text(data['others'] ?? ''),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
