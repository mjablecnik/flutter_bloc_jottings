import 'package:flutter/material.dart';

import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/controllers/item_dialog_controller.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/controllers/note_controller.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/pages/note_page.dart';
import 'package:jottings/app/pages/main_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    ModularApp(
      module: AppModule(),
      child: MaterialApp(
        initialRoute: '/jottingsList/${Folder.root().id}/',
      ).modular(),
    ),
  );
}

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.factory((i) => JottingsListController(i.args!.params['id'])),
    Bind((i) => ItemDialogController()),
    Bind.factory((i) => NoteController(i.args!.params['id'])),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/jottingsList/:id/',
      child: (_, args) => JottingsListPage(args.params['id']),
    ),
    ChildRoute(
      '/note/:id/',
      child: (_, args) => NotePage(args.params['id']),
    ),
  ];
}
