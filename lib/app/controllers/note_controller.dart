import 'dart:async';
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/note.dart';


class NoteState {
  const NoteState._({
    this.note,
    this.errorMessage,
    this.status = Status.loading,
  });

  const NoteState.loading() : this._();

  const NoteState.success(Note note) : this._(note: note, status: Status.success);

  const NoteState.failure(String message) : this._(status: Status.failure, errorMessage: message);

  final Status status;
  final Note? note;
  final String? errorMessage;
}


class NoteController extends Cubit<NoteState> {
  final noteId;

  late final QuillController editor;

  NoteController(this.noteId) : super(NoteState.loading()) {
    if (Item.getTypeFromId(noteId) == ItemType.Note) {
      load();
      Timer.periodic(Duration(seconds: 5), (timer) {
        this.saveContent();
      });
    }
  }

  Future<bool> saveContent() {
    state.note!.content = jsonEncode(editor.document.toDelta().toJson());
    state.note!.save();
    return Future.value(true);
  }

  load() {
    var note = Note.load(noteId);
    try {
      var json = jsonDecode(note!.content);
      var document = Document.fromJson(json);
      editor = QuillController(
        document: document,
        selection: TextSelection.collapsed(offset: document.length-1),
      );
    } catch (e) {
      editor = QuillController.basic();
    }
    emit(NoteState.success(note!));
  }
}
