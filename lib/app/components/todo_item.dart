import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:jottings/app/models/todo.dart' as todo;

class TodoItem extends StatelessWidget {
  todo.TodoItem item;

  TodoItem(
      this.item, {
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
                item.text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Handle(
              delay: const Duration(milliseconds: 100),
              child: Icon(Icons.drag_indicator),
            ),
          ],
        ),
      ),
    );
  }
}
