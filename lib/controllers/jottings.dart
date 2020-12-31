import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/models/item.dart';
import 'package:getx_example/models/note.dart';
import 'package:getx_example/models/todo.dart';
import 'package:getx_example/repositories/folder.dart';
import 'package:getx_example/repositories/note.dart';

class JottingsController extends GetxController {

  NoteRepository _noteRepository;
  FolderRepository _folderRepository;

  List<Item> simpleList = <Item>[].obs;
  Folder currentFolder;

  onInit() {
    super.onInit();
    _noteRepository = Get.find<NoteRepository>();
    _folderRepository = Get.find<FolderRepository>();
    load();
  }

  addItem(String name, ItemType type) async {
    var item;
    switch (type) {
      case ItemType.note:
        item = _noteRepository.save(name, path: currentFolder.path);
        currentFolder.items.add(item);
        _folderRepository.save(currentFolder);
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
    currentFolder = _folderRepository.get(rootFolderName, path: <Folder>[]);

    if (currentFolder != null) {
      simpleList.addAll(currentFolder.items);
    } else {
      currentFolder = _folderRepository.create(rootFolderName, path: <Folder>[]);
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