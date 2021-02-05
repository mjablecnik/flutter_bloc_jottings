import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/controllers/jottings.dart';


class DialogController extends GetxController {

  final JottingsController _controller;
  TextEditingController dialogInput;

  DialogController(this._controller) {
    dialogInput = TextEditingController();
  }

  dialogInputConfirm([ItemType type]) {
    _controller.addItem(dialogInput.text, type);
    clearText();
    Get.back();
  }

  clearText() => dialogInput.text = "";

  open([ItemType type]) {
    Get.defaultDialog(
      onConfirm: () => dialogInputConfirm(type),
      onCancel: clearText,
      textCancel: "Cancel",
      textConfirm: "Confirm",
      content: TextField(
        controller: dialogInput,
        onSubmitted: (_) => dialogInputConfirm(type),
      ),
    );
  }
}
