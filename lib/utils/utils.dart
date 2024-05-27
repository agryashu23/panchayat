import 'package:flutter/material.dart';

double getW(context) {
  return MediaQuery.of(context).size.width;
}

double getH(context) {
  return MediaQuery.of(context).size.height;
}

TextStyle styleText() {
  return const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400);
}
