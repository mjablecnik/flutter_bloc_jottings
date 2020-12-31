import 'package:hive/hive.dart';

import 'item.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends Item {
  @HiveField(50)
  List<Item> items = List<Item>();

  Folder(name, {List<Folder> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);
}
