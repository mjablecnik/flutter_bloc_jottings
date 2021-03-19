import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/jottings_list.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/pages/jottings_list.dart';
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

  await Hive.openBox<Note>(ItemType.note.toString());
  await Hive.openBox<TodoList>(ItemType.todo.toString());
  await Hive.openBox<Folder>(ItemType.folder.toString());

  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      home: JottingsListPage(JottingsListController()),
    ),
  );
}
