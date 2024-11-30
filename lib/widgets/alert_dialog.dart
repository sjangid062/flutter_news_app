import 'package:flutter/material.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {super.key,
      required this.errorTitle,
      required this.errorMessage,
      required this.buttonTitle,
      required this.onPressed});

  final String errorTitle;
  final String errorMessage;
  final String buttonTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
          title: errorTitle,
          color: Colors.red,
          fontSize: 20.0,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold),
      content: TextWidget(
          title: errorMessage,
          color: Colors.grey.shade900,
          fontSize: 14.0,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.normal),
      actions: [
        TextButton(
            onPressed: onPressed,
            child: TextWidget(
                title: buttonTitle,
                color: Colors.black,
                fontSize: 16.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold))
      ],
    );
  }
}
