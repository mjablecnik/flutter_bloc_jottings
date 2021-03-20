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

  String _getCurrentFolderListKey() => "folder_list_ids:${_currentFolder.id}";

  JottingsListController([this._currentFolder]) {
    load();
  }

  addItem(Item item) async {
    item.dirPath = [..._currentFolder.dirPath, _currentFolder.name];
    this.items.add(item);
    item.save();
    _currentFolder.itemIds.add(item.id);
    _currentFolder.save();
    _updateListIds();
  }

  removeItem(Item item) {
    this.items.remove(item);
    //_currentFolder.itemIds.remove(item);
    //_currentFolder.save();
    _updateListIds();
  }

  editItem(Item item) { }

  reorder(int oldIndex, int newIndex) {
    var row = items.removeAt(oldIndex);
    items.insert(newIndex, row);
    _updateListIds();
  }

  _updateListIds() {
    var idsList = items.map((e) => e.id).toList();
    _box.put(_getCurrentFolderListKey(), idsList);
  }

  Folder _getRootFolder() {
    Folder _currentFolder = Item.load(rootFolderId);

    if (_currentFolder != null) {
      return _currentFolder;
    } else {
      return Folder.create(rootFolderId, dirPath: <String>[]);
    }
  }
  
  _loadCurrentFolder() {
    if (_currentFolder == null) {
      _currentFolder = _getRootFolder();
    } else {
      _currentFolder = Item.load(_currentFolder.id);
    }
  }

  _loadItems(List<String> ids) {
    for (var id in ids) {
      items.add(Item.load(id));
    }
  }

  load() {
    _loadCurrentFolder();

    List<dynamic> jottingsListIds = _box.get(_getCurrentFolderListKey());
    if (jottingsListIds == null) {
      _loadItems(_currentFolder.itemIds);
    } else {
      _loadItems(jottingsListIds);
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