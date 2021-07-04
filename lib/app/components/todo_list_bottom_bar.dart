import 'package:flutter/material.dart';
import 'package:jottings/app/controllers/todo_list_controller.dart';

class TodoListBottomBar extends StatelessWidget {
  final TodoListController controller;
  final TextEditingController inputFieldController = TextEditingController();

  TodoListBottomBar(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  controller: inputFieldController,
                  onSubmitted: (text) => controller.addTodo(text),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.addTodo(inputFieldController.text);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.send,
                color: Theme.of(context).bottomAppBarColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
