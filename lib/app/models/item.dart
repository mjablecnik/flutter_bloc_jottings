import 'package:hashids2/hashids2.dart';
import 'package:jottings/app/common/utils.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:hive/hive.dart';

import 'folder.dart';

abstract class Item {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> dirPath = List<String>();

  @HiveField(3)
  DateTime created = DateTime.now();

  @HiveField(4)
  DateTime lastChange = DateTime.now();

  JottingsListController controller;

  get path => [...this.dirPath, name].join("/");

  final HashIds _hashids = HashIds(
    salt: "AH*vQxE^DaR5AM=y8E^n]tR/nv6-]7*GmJ",
    minHashLength: 6,
    alphabet: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
  );

  Item(this.name, {this.id, this.dirPath, this.created, this.lastChange}) {
    if (id == null) {
      id = _getId();
    }
  }

  String _getId() {
    int id = 0;
    if (name != rootFolderId) {
      Box box = Hive.box(BoxStorage.mainBox);
      int lastId = box.get(BoxStorage.idCounter) ?? 0;
      id = ++lastId;
      box.put(BoxStorage.idCounter, id);
    }
    return this.runtimeType.toString() + "_" + _hashids.encode(id);
  }

  save() {}

  delete() {}

  factory Item.load(String id) {
    ItemType type = enumFromString(ItemType.values, id.split("_")[0]);
    switch (type) {
      case ItemType.Note:
        var box = Hive.box<Note>(ItemType.Note.toString());
        return box.get(id);
      case ItemType.TodoList:
        var box = Hive.box<TodoList>(ItemType.TodoList.toString());
        return box.get(id);
      case ItemType.Folder:
        var box = Hive.box<Folder>(ItemType.Folder.toString());
        return box.get(id);
        break;
      default:
        return null;
        break;
    }
  }
}
