import 'package:jottings/app/common/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends Item {

  @HiveField(50)
  String content = "";

  Note(name, {String id, List<String> dirPath, DateTime created, DateTime lastChange})
      : super(name, id: id, dirPath: dirPath, created: created, lastChange: lastChange);

  factory Note.create(name, { List<String> dirPath }) {
    var note = Note(name, dirPath: dirPath);
    note.save();
    return note;
  }

  @override
  save() {
    var box = Hive.box<Note>(ItemType.Note.toString());
    box.put(id, this);
  }

  @override
  delete() {
    var box = Hive.box<Note>(ItemType.Note.toString());
    box.delete(id);
  }

  //static Note load(String id) {
  //  var box = Hive.box<Note>(ItemType.folder.toString());
  //  return box.get(id);
  //}
}
