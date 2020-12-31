import 'package:getx_example/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';
import 'folder.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends Item {

  @HiveField(50)
  String content = "";

  Note(name, {List<Folder> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);

  factory Note.create(name, { List<Folder> path }) {
    var box = Hive.box<Note>(ItemType.note.toString());
    var note = Note(name, path: path);
    box.put(Item.getKey(name, path), note);
    return note;
  }
}
