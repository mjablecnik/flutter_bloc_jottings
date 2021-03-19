import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jottings/controllers/dialog.dart';

class ItemDialog extends GetView<DialogController> {

  ItemDialog({@required model, @required title, @required onSubmit}) {
    controller.title = title;
    controller.model = model;
    controller.onSubmit = onSubmit;
  }

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
                child: Text(controller.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name:"),
                validator: controller.titleValidator,
                initialValue: controller.model.name,
                onSaved: (value) => controller.model.name = value,
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
                      onPressed: () => controller.submit(),
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
