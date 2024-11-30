import 'package:flutter/material.dart';
import 'package:flutter_news_app/utils/dimensions.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              minimumSize: MaterialStatePropertyAll(
                  Size(Dimensions.deviceWidth(), 55.0)),
              backgroundColor: const MaterialStatePropertyAll(Colors.orange)),
          onPressed: onPressed,
          child: TextWidget(
              title: title,
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600)),
    );
  }
}
