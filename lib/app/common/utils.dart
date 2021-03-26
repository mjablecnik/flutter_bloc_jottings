import 'package:hive/hive.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';


T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}

getItemBox(ItemType type) {
  switch (type) {
    case ItemType.Note:
      return Hive.box<Note>(ItemType.Note.toString());
    case ItemType.TodoList:
      return Hive.box<TodoList>(ItemType.TodoList.toString());
    case ItemType.Folder:
      return Hive.box<Folder>(ItemType.Folder.toString());
  }
}