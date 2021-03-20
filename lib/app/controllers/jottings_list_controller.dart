import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/pages/main_page.dart';

class JottingsListController extends GetxController {

  List<Item> items = <Item>[].obs;
  Folder _currentFolder;
  List<JottingsListController> _openedFolders = [];

  Box _box = Hive.box(BoxStorage.jottingsListIds);

  get id => _currentFolder.id;

  String _getListKey() => "folder_list_ids:${_currentFolder.id}";

  JottingsListController([this._currentFolder]) {
    load();
  }

  addItem(Item item) async {
    var createdItem = Item.create(item, path: [..._currentFolder.path, _currentFolder.name]);
    this.items.add(createdItem);
    _currentFolder.items.add(createdItem);
    _currentFolder.save();
    _updateListIds();
  }

  removeItem(Item item) {
    this.items.remove(item);
    _updateListIds();
  }

  editItem(Item item) {

  }

  reorder(int oldIndex, int newIndex) {
    var row = items.removeAt(oldIndex);
    items.insert(newIndex, row);
    _updateListIds();
  }

  _updateListIds() {
    var idsList = items.map((e) => e.id).toList();
    _box.put(_getListKey(), idsList);
  }

  Folder _getRootFolder() {
    Folder _currentFolder = Folder.load(rootFolderName, <String>[]);

    if (_currentFolder != null) {
      return _currentFolder;
    } else {
      return Folder.create(rootFolderName, path: <String>[]);
    }
  }
  
  _loadCurrentFolder() {
    if (_currentFolder == null) {
      _currentFolder = _getRootFolder();
    } else {
      _currentFolder = Folder.load(_currentFolder.name, _currentFolder.path);
    }
  }

  load() {
    _loadCurrentFolder();

    List<dynamic> jottingsListIds = _box.get(_getListKey());
    if (jottingsListIds == null) {
      items.addAll(_currentFolder.items);
    } else {
      for (var id in jottingsListIds) {
        items.add(_currentFolder.items.firstWhere((e) => e.id == id));
      }
    }
  }

  goInto(Item item) {
    if (item.runtimeType == Folder) {
      var folder = _openedFolders.firstWhere((e) => e.id == item.id, orElse: () => null);
      if (folder == null) {
        folder = JottingsListController(item);
        _openedFolders.add(folder);
      }
      Get.to(() => JottingsListPage(folder), preventDuplicates: false);
    }
  }
}