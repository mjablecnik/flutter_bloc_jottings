import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/note.dart';
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

  save(todoList) {
    todoList.save();
  }

  load() {
    var todoList = TodoList.load(todoListId);
    emit(TodoListState.success(todoList!));
  }
}
