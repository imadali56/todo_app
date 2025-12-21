import 'package:flutter/material.dart';

import 'buttons_screen.dart';

class DialogboxScreen extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogboxScreen({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      shape: RoundedRectangleBorder(),
      content: Container(
        height: 114,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add a new Task!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  ButtonsScreen(text: 'Save', onPressed: onSave),
                  SizedBox(width: 15),

                  ButtonsScreen(text: 'Cancel', onPressed: onCancel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
