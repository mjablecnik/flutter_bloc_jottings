import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/domain/entities/folder.dart';
import 'package:getx_example/domain/entities/item.dart';
import 'package:getx_example/domain/entities/note.dart';
import 'package:getx_example/domain/entities/todo.dart';
import 'package:getx_example/domain/services/jotting.dart';

class JottingsController extends GetxController {
  List<Item> simpleList = <Item>[].obs;

  JottingService _jottingService;

  @override
  void onInit() {
    super.onInit();
    _jottingService = Get.find<JottingService>();
  }

  addItem(String name, ItemType type) async {
    var item;
    switch(type) {
      case ItemType.note:
        item = await _jottingService.create(Note(name));
        break;
      case ItemType.todo:
        item = await _jottingService.create(TodoList(name));
        break;
      case ItemType.folder:
        item = await _jottingService.create(Folder(name));
        break;
    }
    simpleList.add(item);
  }

  removeItem(int index) {
    simpleList.removeAt(index);
  }

  editItem() {

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