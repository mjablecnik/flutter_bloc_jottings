import 'item.dart';

class Folder extends Item {
  List<Item> items = [];

  Folder(name, {this.items, created, lastChange}) : super(name, created: created, lastChange: lastChange);
}
