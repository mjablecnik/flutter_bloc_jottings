import 'package:jottings/app/common/constants.dart';
import 'package:hive/hive.dart';

import 'item.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends Item {
  @HiveField(50)
  List<String> itemIds = [];

  bool isRoot = false;

  Folder(name, {String? id, List<String>? dirPath, DateTime? created, DateTime? lastChange, bool? isRoot})
      : super(name, id: id, dirPath: dirPath, created: created, lastChange: lastChange);

  factory Folder.create(name, {List<String>? dirPath, bool? isRoot}) {
    var item = Folder(name, dirPath: dirPath);
    item.save();
    return item;
  }

  @override
  save() {
    var box = Hive.box<Folder>(ItemType.Folder.toString());
    box.put(id, this);
  }

  @override
  delete() {
    var box = Hive.box<Folder>(ItemType.Folder.toString());
    box.delete(id);
  }

  @override
  copy() {
    return Folder(
      name,
      id: id,
      created: created,
      lastChange: lastChange,
      dirPath: dirPath,
      isRoot: isRoot,
    )..itemIds = itemIds;
  }

  copyWith({List<String>? itemIds}) {
    return this.copy()..itemIds = itemIds ?? this.itemIds;
  }

  static Folder root() {
    return Folder.create(rootFolderName, dirPath: <String>[], isRoot: true);
  }

  static Folder? load(String id) {
    return Item.load(id) as Folder?;
  }
}
