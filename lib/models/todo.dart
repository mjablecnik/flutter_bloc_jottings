import 'package:getx_example/constants.dart';
import 'package:hive/hive.dart';

import 'folder.dart';
import 'item.dart';

part 'todo.g.dart';

@HiveType(typeId: 3)
class TodoList extends Item {

  @HiveField(50)
  List<TodoItem> items = [];

  TodoList(name, {List<Folder> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);

  factory TodoList.create(name, { List<Folder> path }) {
    var box = Hive.box<TodoList>(ItemType.todo.toString());
    var note = TodoList(name, path: path);
    box.put(Item.getKey(name, path), note);
    return note;
  }
}

@HiveType(typeId: 4)
class TodoItem {

  @HiveField(0)
  String name;

  @HiveField(1)
  String checked;

  TodoItem(this.name, this.checked);
}
