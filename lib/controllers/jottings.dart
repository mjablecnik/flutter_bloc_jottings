import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/models/folder.dart';
import 'package:getx_example/models/item.dart';
import 'package:getx_example/models/note.dart';
import 'package:getx_example/models/todo.dart';

class JottingsController extends GetxController {
  List<Item> simpleList = <Item>[].obs;

  addItem(String name, ItemType type) async {
    var item;
    switch(type) {
      case ItemType.note:
        item = Note(name);
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

  list() {

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