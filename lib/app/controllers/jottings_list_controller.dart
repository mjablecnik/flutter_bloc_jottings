import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/pages/main_page.dart';

class JottingsListController extends GetxController {
  List<Rx<Item>> items = <Rx<Item>>[].obs;
  late Folder _currentFolder;
  List<JottingsListController> _openedFolders = [];

  Box _box = Hive.box(BoxStorage.jottingsListIds);

  String? get id => _currentFolder.id;

  Folder get folder => _currentFolder;

  String _getCurrentFolderListKey() => "folder_list_ids:${_currentFolder.id}";

  JottingsListController(currentFolder) {
    _currentFolder = currentFolder;
    load();
  }

  addItem(Item item) async {
    item.dirPath = [..._currentFolder.dirPath!, _currentFolder.name];
    this.items.add(item.obs);
    item.save();
    _currentFolder.itemIds.add(item.id!);
    _currentFolder.save();
    _updateListIds();
  }

  _removeFolderItems(Folder folder) async {
    for (String itemId in folder.itemIds) {
      if (Item.getTypeFromId(itemId) == ItemType.Folder) {
        var openedFolderController = _openedFolders.where((element) => element.folder.id == itemId);
        Folder item = openedFolderController.isEmpty ? Folder.load(itemId)! : openedFolderController.first.folder;
        this._removeFolderItems(item);
        item.delete();
      } else {
        Item.load(itemId)!.delete();
      }
    }
  }

  removeItem(Item item) {
    this.items.remove(item);
    if (item.runtimeType == Folder) {
      _removeFolderItems(item as Folder);
      _openedFolders.removeWhere((element) => element.folder.id == item.id);
    }
    _currentFolder.itemIds.remove(item.id);
    _currentFolder.save();
    _updateListIds();
  }

  editItem(Item item) {
    var changedItem = items.where((element) => element.value!.id == item.id).first;
    changedItem(item);
    changedItem.value!.save();
  }

  reorder(int oldIndex, int newIndex) {
    var row = items.removeAt(oldIndex);
    items.insert(newIndex, row);
    _updateListIds();
  }

  _updateListIds() {
    var idsList = items.map((e) => e.value!.id).toList();
    _box.put(_getCurrentFolderListKey(), idsList);
  }

  _loadCurrentFolder() {
    Folder? folder = Folder.load(_currentFolder.id!);

    if (folder != null) {
      _currentFolder = folder;
    }
  }

  _loadItems(List<String> ids) {
    _currentFolder.itemIds = List.from(ids);
    for (var id in ids) {
      items.add(Item.load(id)!.obs);
    }
  }

  load() {
    _loadCurrentFolder();

    List<dynamic>? jottingsListIds = _box.get(_getCurrentFolderListKey());
    if (jottingsListIds != null) {
      _loadItems(List.from(jottingsListIds));
    }
  }

  goInto(Item item) {
    if (item.runtimeType == Folder) {
      late var folder;
      var folderList = _openedFolders.where((e) => e.id == item.id);
      if (folderList.isEmpty) {
        folder = JottingsListController(item);
        _openedFolders.add(folder);
      } else {
        folder = folderList.first;
      }
      Get.to(
        () => JottingsListPage(folder!),
        preventDuplicates: false,
        duration: Duration(seconds: 0),
      );
    }
  }
}
