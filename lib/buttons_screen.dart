import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {

final String text;
VoidCallback onPressed;
 ButtonsScreen({super.key, required this.text, required this.onPressed});
@override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
    child: Text(text),
      color: Colors.yellow,



    );
  }
}
