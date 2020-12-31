import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/models/item.dart';
import 'package:getx_example/models/note.dart';
import 'package:getx_example/models/todo.dart';
import 'package:getx_example/pages/jottings.dart';

class JottingsController extends GetxController {

  List<Item> items = <Item>[Note.create("testItem1"), Note.create("testItem2")].obs;
  Folder _currentFolder;


  onInit() {
    super.onInit();
    _currentFolder = Get.arguments;
    load();
  }

  addItem(String name, ItemType type) async {
    var item = Item.create(name, path: _currentFolder.path, type: type);
    this.items.add(item);
    _currentFolder.items.add(item);
    _currentFolder.save();
  }

  removeItem(int index) {
    this.items.removeAt(index);
  }

  editItem() {

  }

  load() {
    if (_currentFolder != null) return;

    _currentFolder = Folder.load(rootFolderName, <Folder>[]);

    if (_currentFolder != null) {
      this.items.addAll(_currentFolder.items);
    } else {
      _currentFolder = Folder.create(rootFolderName, path: <Folder>[]);
    }
  }

  goNext(Item item) {
    if (item.runtimeType == Folder) {
      print("Going to next folder..");
      Get.to(JottingsPage(), arguments: item);
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