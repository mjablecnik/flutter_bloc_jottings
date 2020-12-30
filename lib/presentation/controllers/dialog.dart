import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'basic.dart';

class DialogController extends GetxController {

  BasicController _controller;
  TextEditingController dialogInput;

  onInit() {
    super.onInit();
    _controller = Get.find<BasicController>();
    dialogInput = TextEditingController();
    print("Create dialogController");
  }

  onClose() {
    super.onClose();
    dialogInput.dispose();
    print("Dispose dialogController");
  }

  dialogInputConfirm() {
    _controller.simpleList.add(dialogInput.text);
    clearDialog();
    Get.back();
  }

  clearDialog() => dialogInput.text = "";
}
