import 'package:flutter/material.dart';
import 'package:todo/utils.dart/button.dart';

class MyDialogBox extends StatelessWidget {
  final controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyDialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[400],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Task",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(text: "Save", onPressed: onSave),
                  const SizedBox(
                    width: 8,
                  ),
                  MyButton(text: "Cancel", onPressed: onCancel)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
