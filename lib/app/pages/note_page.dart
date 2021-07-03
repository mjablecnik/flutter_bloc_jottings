import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:jottings/app/controllers/note_controller.dart';

class NotePage extends StatelessWidget {
  final String noteId;

  final controller = Modular.get<NoteController>();

  NotePage(this.noteId);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.state.note!.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              controller.save(controller.state.note);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          QuillToolbar.basic(controller: controller.editor),
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
    );
  }
}
