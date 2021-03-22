import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/widgets/item_dialog.dart';
import 'package:jottings/app/widgets/jottings_list.dart';

class JottingsListPage extends StatelessWidget {

  final JottingsListController controller;

  JottingsListPage(this.controller);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(controller.folder.path)),
      body: JottingsList(controller),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue,
        onTap: (index) {
          var onSubmit = (item) => controller.addItem(item);
          switch (index) {
            case 0: ItemDialog.getDialog(context, Note(""), Texts.addNoteItem, onSubmit); break;
            case 1: ItemDialog.getDialog(context, TodoList(""), Texts.addTodoListItem, onSubmit); break;
            case 2: ItemDialog.getDialog(context, Folder(""), Texts.addFolderItem, onSubmit); break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.notes_outlined), label: Texts.addNoteItem),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: Texts.addTodoListItem),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: Texts.addFolderItem),
        ],
      ),
    );
  }
}
