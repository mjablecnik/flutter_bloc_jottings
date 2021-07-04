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
                Todo("Todo1"),
                Todo("Todo2"),
                Todo("Todo3"),
                Todo("Todo4"),
                Todo("Todo1"),
                Todo("Todo2"),
                Todo("Todo3"),
                Todo("Todo4"),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Add todo..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.send, color: Theme.of(context).bottomAppBarColor,),
                )
              ],
            ),
          ),
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
