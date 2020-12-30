import 'item.dart';

class Note extends Item {
  String content = "";

  Note(name, {this.content, created, lastChange}) : super(name, created: created, lastChange: lastChange);
}
