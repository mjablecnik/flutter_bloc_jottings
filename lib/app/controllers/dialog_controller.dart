import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class DialogController extends GetxController {

  final TextEditingController dialogInput = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var model;
  late String title;
  late Function onSubmit;

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onSubmit.call(model);
      clearText();
      Get.back();
    }
  }

  void clearText() => dialogInput.text = "";

  String? titleValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
