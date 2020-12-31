import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/controllers/dialog.dart';
import 'package:getx_example/controllers/jottings.dart';

class JottingsPage extends GetView<JottingsController> {
  @override
  Widget build(context) {
    var dialogController = Get.find<DialogController>();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.simpleList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              margin: const EdgeInsets.all(5),
              color: controller.getItemColor(controller.simpleList[index].runtimeType),
              child: Center(
                child: Text(controller.simpleList[index].name),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ButtonBar(
        buttonMinWidth: Get.width / 3.5,
        alignment: MainAxisAlignment.center,
        children: <RaisedButton>[
          RaisedButton(onPressed: () => dialogController.open(ItemType.note), child: Text("Add note")),
          RaisedButton(onPressed: () => dialogController.open(ItemType.todo), child: Text("Add todo")),
          RaisedButton(onPressed: () => dialogController.open(ItemType.folder), child: Text("Add folder")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: dialogController.open,
      ),
    );
  }
}
