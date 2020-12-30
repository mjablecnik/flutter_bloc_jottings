import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/presentation/controllers/basic.dart';
import 'package:getx_example/presentation/controllers/dialog.dart';

class Other extends GetView<BasicController> {
  @override
  Widget build(context) {
    // Access the updated count variable
    var dialogController = Get.find<DialogController>();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.simpleList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                color: Colors.amber[600],
                child: Center(
                  child: Text(controller.simpleList[index]),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Get.defaultDialog(
            onConfirm: dialogController.dialogInputConfirm,
            onCancel: dialogController.clearDialog,
            middleText: "Dialog made in 3 lines of code",
            textCancel: "Cancel",
            textConfirm: "Confirm",
            content: TextField(
              controller: dialogController.dialogInput,
              onSubmitted: (_) => dialogController.dialogInputConfirm(),
            ),
          ),
        },
      ),
    );
  }
}
