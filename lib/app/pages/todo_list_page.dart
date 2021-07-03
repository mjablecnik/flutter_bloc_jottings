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
      body: Column(
        children: [
          Text("Todo list:")
        ],
      ),
    );
  }
}
