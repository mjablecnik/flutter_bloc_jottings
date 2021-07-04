import 'package:jottings/app/common/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';

part 'todo.g.dart';

@HiveType(typeId: 3)
class TodoList extends Item {

  @HiveField(50)
  List<TodoItem> items = [];

  TodoList(name, {String? id, List<String>? dirPath, DateTime? created, DateTime? lastChange})
      : super(name, id: id, dirPath: dirPath, created: created, lastChange: lastChange);

  factory TodoList.create(name, { List<String>? dirPath }) {
    var note = TodoList(name, dirPath: dirPath);
    note.save();
    return note;
  }

  @override
  save() {
    var box = Hive.box<TodoList>(ItemType.TodoList.toString());
    box.put(id, this);
  }

  @override
  delete() {
    var box = Hive.box<TodoList>(ItemType.TodoList.toString());
    box.delete(id);
  }

  @override
  copy() {
    return TodoList(
      name,
      id: id,
      created: created,
      lastChange: lastChange,
      dirPath: dirPath,
    )..items = items;
  }

  static TodoList? load(String id) {
    return Item.load(id) as TodoList?;
  }
}

@HiveType(typeId: 4)
class TodoItem {

  @HiveField(0)
  String text;

  @HiveField(1)
  bool checked;

  TodoItem(this.text, this.checked);
}
