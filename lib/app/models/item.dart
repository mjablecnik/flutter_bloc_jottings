import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:hive/hive.dart';

import 'folder.dart';

class Item {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> path = List<String>();

  @HiveField(2)
  DateTime created = DateTime.now();

  @HiveField(3)
  DateTime lastChange = DateTime.now();

  get id => [...this.path, name].join("/");

  Item(this.name, {this.path, this.created, this.lastChange});

  static String getKeyByItem(Item item) {
    if (item.path != null && item.path.isNotEmpty) {
      return pathSeparator + item.path.join(pathSeparator) + pathSeparator + item.name;
    } else {
      return pathSeparator + item.name;
    }
  }

  static String getKey(String name, List<String> path) {
    return getKeyByItem(Item(name, path: path));
  }

  factory Item.create(Item item, {List<String> path}) {
    switch (item.runtimeType) {
      case Note:
        return Note.create(item.name, path: path);
        break;
      case TodoList:
        return TodoList.create(item.name, path: path);
        break;
      case Folder:
        return Folder.create(item.name, path: path);
        break;
      default:
        return null;
        break;
    }
  }
}
