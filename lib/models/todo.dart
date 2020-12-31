import 'folder.dart';
import 'item.dart';

class TodoList extends Item {
  List<TodoItem> items = [];

  TodoList(name, {List<Folder> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);
}

class TodoItem {
  String name;
  String checked;

  TodoItem(this.name, this.checked);
}
