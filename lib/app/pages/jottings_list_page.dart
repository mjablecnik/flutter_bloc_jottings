import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/widgets/item_dialog.dart';
import 'package:jottings/app/components/jottings_list.dart';

class JottingsListPage extends StatelessWidget {

  final String folderId;

  final controller = Modular.get<JottingsListController>();

  JottingsListPage(this.folderId);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(controller.state.folder!.path)),
      body: JottingsList(controller),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue,
        backgroundColor: Colors.grey.shade100,
        onTap: (index) {
          var onSubmit = (item) => controller.addItem(item);
          switch (index) {
            case 0: ItemDialog.getDialog(context, item: Note(Texts.defaultItemName), title: Texts.addNoteItem, onSubmit: onSubmit); break;
            case 1: ItemDialog.getDialog(context, item: TodoList(Texts.defaultItemName), title: Texts.addTodoListItem, onSubmit: onSubmit); break;
            case 2: ItemDialog.getDialog(context, item: Folder(Texts.defaultItemName), title: Texts.addFolderItem, onSubmit: onSubmit); break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.notes_outlined), label: Texts.addNoteItem),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: Texts.addTodoListItem),
          BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: Texts.addFolderItem),
        ],
      ),
    );
  }
}
