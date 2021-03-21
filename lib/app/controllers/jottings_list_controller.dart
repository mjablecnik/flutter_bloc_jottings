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

  String get id => _currentFolder.id;

  Folder get folder => _currentFolder;

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

  _removeFolderItems(Folder folder) async {
    for (String itemId in folder.itemIds) {
      if (Item.getTypeFromId(itemId) == ItemType.Folder) {
        var openedFolderController = _openedFolders.where((element) => element.folder.id == itemId);
        Folder item = openedFolderController.isEmpty ? Item.load(itemId) : openedFolderController.first.folder;
        this._removeFolderItems(item);
        item.delete();
      } else {
        Item.load(itemId).delete();
      }
    }
  }

  removeItem(Item item) {
    this.items.remove(item);
    if (item.runtimeType == Folder) {
      _removeFolderItems(item);
      _openedFolders.removeWhere((element) => element.folder.id == item.id);
    }
    _currentFolder.itemIds.remove(item.id);
    _currentFolder.save();
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
      return Folder.create(rootFolderName, dirPath: <String>[]);
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