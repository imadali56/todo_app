import 'package:flutter/material.dart';
import 'buttons_screen.dart';

class DialogboxScreen extends StatelessWidget {
  final TextEditingController titleController; // Title ke liye
  final TextEditingController descController;  // Description ke liye
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogboxScreen({
    super.key,
    required this.titleController,
    required this.descController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Container(
        height: 220,
        child: Column(
          children: [
            // Title Input
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter Task Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: 'Enter Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonsScreen(text: 'Save', onPressed: onSave),
                const SizedBox(width: 15),
                ButtonsScreen(text: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}