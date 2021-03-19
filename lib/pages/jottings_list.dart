import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jottings/controllers/dialog.dart';
import 'package:jottings/controllers/jottings_list.dart';
import 'package:jottings/models/folder.dart';
import 'package:jottings/models/note.dart';
import 'package:jottings/models/todo.dart';
import 'package:jottings/widgets/item_dialog.dart';

class JottingsListPage extends StatelessWidget {

  final JottingsListController controller;

  JottingsListPage(this.controller);

  getDialog(context, item, title) {
    Get.put(DialogController());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(
          title: title,
          model: item,
          onSubmit: (item) => controller.addItem(item),
        );
      },
    );
  }

  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("HashCode: " + controller.hashCode.toString())),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.goNext(controller.items[index]),
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                color: controller.getItemColor(controller.items[index].runtimeType),
                child: Center(
                  child: Text(controller.items[index].name),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ButtonBar(
        buttonMinWidth: Get.width / 3.5,
        alignment: MainAxisAlignment.center,
        children: <RaisedButton>[
          RaisedButton(onPressed: () => getDialog(context, Note(""), "Add note"), child: Text("Add note")),
          RaisedButton(onPressed: () => getDialog(context, TodoList(""), "Add todo"), child: Text("Add todo")),
          RaisedButton(onPressed: () => getDialog(context, Folder(""), "Add folder"), child: Text("Add folder")),
        ],
      ),
    );
  }
}
