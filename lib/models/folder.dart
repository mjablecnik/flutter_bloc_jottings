import 'package:getx_example/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends Item {
  @HiveField(50)
  List<Item> items = List<Item>();

  Folder(name, {List<Folder> path, DateTime created, DateTime lastChange})
      : super(name, path: path, created: created, lastChange: lastChange);


  factory Folder.create(name, { List<Folder> path }) {
    var box = Hive.box<Folder>(ItemType.folder.toString());
    var item = Folder(name, path: path);
    box.put(Item.getKeyByItem(item), item);
    return item;
  }

  static Folder load(String name, List<Folder> path) {
    var box = Hive.box<Folder>(ItemType.folder.toString());
    return box.get(Item.getKey(name, path));
  }
}
