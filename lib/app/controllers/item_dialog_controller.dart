import 'package:flutter/widgets.dart';

class ItemDialogController {
  final formKey = GlobalKey<FormState>();

  String? titleValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void submit(context, widget) {
    if (this.formKey.currentState!.validate()) {
      this.formKey.currentState!.save();
      widget.onSubmit.call(widget.model);
      Navigator.pop(context);
    }
  }
}
