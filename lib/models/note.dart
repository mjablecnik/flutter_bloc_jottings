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
}
