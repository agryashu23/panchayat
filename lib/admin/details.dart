import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/utils/utils.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("विवरण"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Center(
                  child: Image.network(
                    item['image'],
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                  child: Text(
                item['name'],
                style: styleText(),
              )),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "परिवार के मुखिया का मतदाता न.",
                    style: TextStyle(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
