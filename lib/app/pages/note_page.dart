import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jottings/app/controllers/note_controller.dart';

class NotePage extends StatelessWidget {

  final String noteId;

  final controller = Modular.get<NoteController>();

  NotePage(this.noteId);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Test title")),
      body: Center(child: Text(controller.state.content)),
    );
  }
}
