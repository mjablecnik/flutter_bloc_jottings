import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
    var onSubmit = (item) => controller.addItem(item);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("HashCode: " + controller.hashCode.toString())),
      body: JottingsList(controller),
      bottomNavigationBar: ButtonBar(
        buttonMinWidth: Get.width / 3.5,
        alignment: MainAxisAlignment.center,
        children: <RaisedButton>[
          RaisedButton(onPressed: () => ItemDialog.getDialog(context, Note(""), "Add note", onSubmit), child: Text("Add note")),
          RaisedButton(onPressed: () => ItemDialog.getDialog(context, TodoList(""), "Add todo", onSubmit), child: Text("Add todo")),
          RaisedButton(onPressed: () => ItemDialog.getDialog(context, Folder(""), "Add folder", onSubmit), child: Text("Add folder")),
        ],
      ),
    );
  }
}
