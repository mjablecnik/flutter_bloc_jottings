import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jottings/app/controllers/todo_list_controller.dart';

class TodoListPage extends StatelessWidget {
  final String todoListId;

  final controller = Modular.get<TodoListController>();

  TodoListPage(this.todoListId);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.state.todoList!.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              print("TODO: Add todo");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "Todo list:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Todo("Todo1"),
                  Todo("Todo2"),
                  Todo("Todo3"),
                  Todo("Todo4"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Todo extends StatelessWidget {
  String text;

  Todo(
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
