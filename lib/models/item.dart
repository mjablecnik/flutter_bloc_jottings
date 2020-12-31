
import 'package:hive/hive.dart';

import 'folder.dart';


abstract class Item {

  @HiveField(0)
  String name;

  @HiveField(1)
  List<Folder> path = List<Folder>();

  @HiveField(2)
  DateTime created = DateTime.now();

  @HiveField(3)
  DateTime lastChange = DateTime.now();

  Item(this.name, {this.path, this.created, this.lastChange});
}