import 'package:get/get.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/repositories/base.dart';
import 'package:hive/hive.dart';
import 'package:getx_example/constants.dart';

class FolderRepository extends GetxService with BaseRepository {

  var _box;

  onInit() {
    super.onInit();
    _box = Hive.box<Folder>(ItemType.folder.toString());
  }

  onClose() {
    _box.close();
  }

  Folder create(name, { List<Folder> path }) {
    var item = Folder(name, path: path);
    _box.put(getKey(name, path), item);
    return item;
  }

  void save(Folder folder) {
    _box.put(getKey(folder.name, folder.path), folder);
  }

  Folder get(name, { List<Folder> path }) {
    return _box.get(getKey(name, path));
  }
}