import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Home extends StatelessWidget {

  final Controller controller = Get.put(Controller());

  @override
  Widget build(context) {
    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(
        title: Obx(
          () => Text("Clicks: ${controller.count}"),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(
        child: RaisedButton(
          child: Text("Go to Other"),
          onPressed: () => Get.toNamed('/other'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}

class Other extends GetView<Controller> {
  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: controller.testList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(
              child: Text(controller.testList[index]),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.addToList("next item"),
      ),
    );
  }
}
