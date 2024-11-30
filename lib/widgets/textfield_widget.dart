import 'package:flutter/material.dart';
import 'package:flutter_news_app/utils/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key, required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Dimensions.deviceWidth(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ));
  }
}
