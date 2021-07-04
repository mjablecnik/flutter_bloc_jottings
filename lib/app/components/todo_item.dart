import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:jottings/app/controllers/todo_list_controller.dart';
import 'package:jottings/app/models/todo.dart' as todo;

class TodoItem extends StatelessWidget {
  final todo.TodoItem item;
  final TodoListController controller;

  TodoItem(
    this.item, {
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => controller.toggleTodo(item),
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: item.checked ? const Icon(Icons.check_box, color: Colors.blueGrey) : const Icon(Icons.check_box_outline_blank),
              ),
            ),
            Expanded(
              child: Text(
                item.text,
                style: item.checked
                    ? const TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.grey)
                    : const TextStyle(fontSize: 16),
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
