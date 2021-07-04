import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jottings/app/components/todo_item.dart';
import 'package:jottings/app/components/todo_list_bottom_bar.dart';
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
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Todo list:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                TodoItem("Todo1"),
                TodoItem("Todo2"),
                TodoItem("Todo3"),
                TodoItem("Todo4"),
                TodoItem("Todo1"),
                TodoItem("Todo2"),
                TodoItem("Todo3"),
                TodoItem("Todo4"),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TodoListBottomBar(),
        ),
      ),
    );
  }
}


