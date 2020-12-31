import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/models/item.dart';
import 'package:getx_example/models/note.dart';
import 'package:getx_example/models/todo.dart';

class JottingsController extends GetxController {

  List<Item> simpleList = <Item>[].obs;
  Folder currentFolder;

  onInit() {
    super.onInit();
    load();
  }

  addItem(String name, ItemType type) async {
    var item;
    switch (type) {
      case ItemType.note:
        item = Note.create(name, path: currentFolder.path);
        currentFolder.items.add(item);
        currentFolder.save();
        break;
      case ItemType.todo:
        item = TodoList(name);
        break;
      case ItemType.folder:
        item = Folder(name);
        break;
    }
    simpleList.add(item);
  }

  removeItem(int index) {
    simpleList.removeAt(index);
  }

  editItem() {

  }

  load() {
    currentFolder = Folder.load(rootFolderName, <Folder>[]);

    if (currentFolder != null) {
      simpleList.addAll(currentFolder.items);
    } else {
      currentFolder = Folder.create(rootFolderName, path: <Folder>[]);
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