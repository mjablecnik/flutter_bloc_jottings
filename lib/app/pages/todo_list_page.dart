import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:jottings/app/components/todo_item.dart';
import 'package:jottings/app/components/todo_list_bottom_bar.dart';
import 'package:jottings/app/controllers/todo_list_controller.dart';
import 'package:jottings/app/models/todo.dart' as todo;

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
          BlocBuilder<TodoListController, TodoListState>(
            bloc: controller,
            builder: (context, state) {
              return IconButton(
                icon: controller.state.todoList!.isCheckedVisible == true
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: controller.toggleCheckedVisibility,
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoListController, TodoListState>(
              bloc: controller,
              builder: (context, state) {
                return ImplicitlyAnimatedReorderableList<todo.TodoItem>(
                  items: controller.items,
                  areItemsTheSame: (oldItem, newItem) => oldItem.text == newItem.text,
                  onReorderFinished: (item, from, to, newItems) {
                    controller.reorder(from!, to);
                  },
                  itemBuilder: (context, itemAnimation, item, index) {
                    return Reorderable(
                      key: ValueKey(item),
                      builder: (context, dragAnimation, inDrag) {
                        return SizeFadeTransition(
                          sizeFraction: 0.5,
                          curve: Curves.easeIn,
                          animation: itemAnimation,
                          child: Dismissible(
                            key: GlobalKey(),
                            child: TodoItem(item, controller: controller),
                            onDismissed: (direction) => controller.removeTodo(item),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TodoListBottomBar(controller),
        ),
      ),
    );
  }
}
