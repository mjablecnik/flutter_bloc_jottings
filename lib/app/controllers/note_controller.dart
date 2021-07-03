import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/item.dart';

enum Status { loading, success, failure }

class NoteState {
  const NoteState._({
    this.status = Status.loading,
    this.content = "",
  });

  const NoteState.loading() : this._();

  const NoteState.success(String content)
      : this._(status: Status.success, content: content);

  const NoteState.failure() : this._(status: Status.failure);

  final Status status;
  final String content;
}


class NoteController extends Cubit<NoteState> {

  final noteId;

  NoteController(this.noteId) : super(NoteState.loading()) {
    if (Item.getTypeFromId(noteId) == ItemType.Note) {
      load(noteId);
    }
  }

  load(String folderId) {
    emit(NoteState.success("Test text 123"));
  }
}
