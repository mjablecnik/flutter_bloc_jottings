import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/todo.dart';

class TodoListState {
  const TodoListState._({
    this.todoList,
    this.errorMessage,
    this.status = Status.loading,
  });

  const TodoListState.loading() : this._();

  const TodoListState.success(TodoList todoList) : this._(todoList: todoList, status: Status.success);

  const TodoListState.failure(String message) : this._(status: Status.failure, errorMessage: message);

  final Status status;
  final TodoList? todoList;
  final String? errorMessage;
}

class TodoListController extends Cubit<TodoListState> {
  final todoListId;

  TodoListController(this.todoListId) : super(TodoListState.loading()) {
    if (Item.getTypeFromId(todoListId) == ItemType.TodoList) {
      load();
    }
  }

  get items => state.todoList!.isCheckedVisible == true
      ? state.todoList!.items
      : state.todoList!.items.where((element) => !element.checked).toList();

  addTodo(String text) {
    if (text.isNotEmpty) {
      state.todoList!.items = [TodoItem(text, false), ...state.todoList!.items];
      state.todoList!.save();
      emit(TodoListState.success(state.todoList!));
    }
  }

  removeTodo(TodoItem todoItem) {
    state.todoList!.items.remove(todoItem);
    state.todoList!.save();
  }

  toggleTodo(TodoItem todoItem) {
    todoItem.checked = !todoItem.checked;
    state.todoList!.items = [
      ...state.todoList!.items.where((element) => !element.checked),
      ...state.todoList!.items.where((element) => element.checked)
    ];
    state.todoList!.save();
    emit(TodoListState.success(state.todoList!));
  }

  toggleCheckedVisibility() {
    state.todoList!.isCheckedVisible =
        state.todoList!.isCheckedVisible == null ? true : !state.todoList!.isCheckedVisible!;
    state.todoList!.save();
    emit(TodoListState.success(state.todoList!));
  }

  reorder(int oldIndex, int newIndex) {
    var item = state.todoList!.items.removeAt(oldIndex);
    state.todoList!.items.insert(newIndex, item);
    state.todoList!.save();
  }

  load() {
    var todoList = TodoList.load(todoListId);
    emit(TodoListState.success(todoList!));
  }
}
