import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  String text;

  TodoItem(
      this.text, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: const Icon(Icons.check_box_outline_blank),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.drag_indicator),
          ],
        ),
      ),
    );
  }
}
