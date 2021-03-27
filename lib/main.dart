import 'package:flutter/material.dart';

import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/pages/main_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(NoteAdapter())
    ..registerAdapter(TodoListAdapter())
    ..registerAdapter(TodoItemAdapter())
    ..registerAdapter(FolderAdapter());

  await Hive.openBox(BoxStorage.mainBox);
  await Hive.openBox(BoxStorage.jottingsListIds);
  await Hive.openBox<Note>(ItemType.Note.toString());
  await Hive.openBox<TodoList>(ItemType.TodoList.toString());
  await Hive.openBox<Folder>(ItemType.Folder.toString());


  runApp(
    MaterialApp(
      home: JottingsListPage(JottingsListController(Folder.root())),
    ),
  );
}
