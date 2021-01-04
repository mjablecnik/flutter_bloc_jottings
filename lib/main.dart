import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/controllers/basic.dart';
import 'package:getx_example/controllers/dialog.dart';
import 'package:getx_example/controllers/jottings.dart';
import 'package:getx_example/models/todo.dart';
import 'package:getx_example/pages/home.dart';
import 'package:getx_example/pages/jottings.dart';
import 'package:getx_example/pages/other.dart';
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
      initialRoute: Routes.JOTTINGS,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.create(() => DialogController());
        Get.create(() => JottingsController());
        //Get.lazyPut(() => JottingsController(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => Home()),
        GetPage(name: Routes.OTHER, page: () => Other()),
        GetPage(name: Routes.JOTTINGS, page: () => JottingsPage()),
      ]),
  );
}
