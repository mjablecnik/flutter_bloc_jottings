import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jottings/common/constants.dart';
import 'package:jottings/controllers/jottings_list.dart';
import 'package:jottings/models/todo.dart';
import 'package:jottings/pages/jottings_list.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/folder.dart';
import 'models/note.dart';

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
