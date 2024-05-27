import 'package:flutter/material.dart';

Widget textField(var setValue, TextInputType type, double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: SizedBox(
      width: width,
      child: TextFormField(
        initialValue: setValue.value,
        keyboardType: type,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (value) {
          setValue.value = value;
        },
      ),
    ),
  );
}

Widget textField2(String initialValue, TextInputType type, double width,
    String hint, ValueChanged<String> onChanged) {
  return SizedBox(
    width: width,
    child: TextFormField(
      initialValue: initialValue,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: onChanged,
    ),
  );
}

Widget btn() {
  return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 50,
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(12)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("आगे बढ़ें",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          Icon(Icons.arrow_right)
        ],
      ));
}

snackbar(context) {
  return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("कृपया पूरा भरें"),
    duration: Duration(seconds: 1),
  ));
}
