import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/pages/main_page.dart';

class JottingsListController extends GetxController {

  List<Item> items = <Item>[].obs;
  Folder _currentFolder;
  List<JottingsListController> _openedFolders = [];

  get id => _currentFolder.id;

  JottingsListController([this._currentFolder]) {
    load();
  }

  addItem(Item item) async {
    var createdItem = Item.create(item, path: [..._currentFolder.path, _currentFolder.name]);
    this.items.add(createdItem);
    _currentFolder.items.add(createdItem);
    _currentFolder.save();
  }

  removeItem(Item item) {
    this.items.remove(item);
  }

  editItem(Item item) {

  }

  _loadRootFolder() {
    _currentFolder = Folder.load(rootFolderName, <String>[]);

    if (_currentFolder != null) {
      this.items.addAll(_currentFolder.items);
    } else {
      _currentFolder = Folder.create(rootFolderName, path: <String>[]);
    }
  }

  load() {
    if (_currentFolder == null) {
      _loadRootFolder();
    } else {
      _currentFolder = Folder.load(_currentFolder.name, _currentFolder.path);
      this.items.addAll(_currentFolder.items);
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

  getItemColor(Type item) {
    switch (item) {
      case Note:
        return Colors.blue;
        break;
      case TodoList:
        return Colors.green;
        break;
      case Folder:
        return Colors.black38;
        break;
      default:
        return Colors.red;
        break;
    }
  }
}