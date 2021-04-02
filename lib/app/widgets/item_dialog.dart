import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jottings/app/models/item.dart';

class ItemDialog extends StatefulWidget {
  late String title;
  late Item model;
  late ValueSetter<Item> onSubmit;

  ItemDialog({required model, required title, required onSubmit}) {
    this.title = title;
    this.model = model;
    this.onSubmit = onSubmit;
  }

  static getDialog(context, {required Item item, required String title, required ValueSetter<Item> onSubmit}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(
          title: title,
          model: item,
          onSubmit: onSubmit,
        );
      },
    );
  }

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

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

class _ItemDialogState extends ModularState<ItemDialog, ItemDialogController> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name:"),
                validator: controller.titleValidator,
                initialValue: widget.model.name,
                onSaved: (value) => widget.model.name = value!,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: ButtonBar(
                  children: [
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.submit(context, widget),
                      child: Text("Submit"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
