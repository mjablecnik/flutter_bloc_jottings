import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/note_controller.dart';

class NotePage extends StatelessWidget {
  final String noteId;

  final controller = Modular.get<NoteController>();

  NotePage(this.noteId);

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: controller.saveContent,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(controller.state.note!.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                controller.saveContent();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(Texts.saveSnackBar),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            QuillToolbar.basic(
              controller: controller.editor,
              showCodeBlock: false,
              showQuote: false,
              showLink: false,
              // multiRowsDisplay: false,
            ),
            Expanded(
              child: Container(
                child: QuillEditor.basic(
                  controller: controller.editor,
                  readOnly: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
