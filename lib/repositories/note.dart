import 'package:get/get.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/repositories/base.dart';
import 'package:hive/hive.dart';
import 'package:getx_example/models/note.dart';
import 'package:getx_example/constants.dart';

class NoteRepository extends GetxService with BaseRepository {

  var _box;

  onInit() {
    super.onInit();
    _box = Hive.box<Note>(ItemType.note.toString());
  }

  onClose() {
    _box.close();
  }

  Note save(name, { List<Folder> path }) {
    var note = Note(name);
    _box.put(getKey(name, path), note);
    return note;
  }
}