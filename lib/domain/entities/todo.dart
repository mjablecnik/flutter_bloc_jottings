import 'item.dart';

class TodoList extends Item {
  List<TodoItem> items = [];

  TodoList(name, {this.items, created, lastChange}) : super(name, created: created, lastChange: lastChange);
}

class TodoItem {
  String name;
  String checked;

  TodoItem(this.name, this.checked);
}
