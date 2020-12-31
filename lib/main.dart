import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/controllers/basic.dart';
import 'package:getx_example/controllers/dialog.dart';
import 'package:getx_example/controllers/jottings.dart';
import 'package:getx_example/pages/home.dart';
import 'package:getx_example/pages/jottings.dart';
import 'package:getx_example/pages/other.dart';
import 'package:getx_example/repositories/folder.dart';
import 'package:getx_example/repositories/note.dart';
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
    ..registerAdapter(FolderAdapter());

  await Hive.openBox<Note>(ItemType.note.toString());
  await Hive.openBox<Folder>(ItemType.folder.toString());

  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.create(() => DialogController());
        Get.lazyPut(() => JottingsController(), fenix: true);
        Get.lazyPut(() => NoteRepository(), fenix: true);
        Get.lazyPut(() => FolderRepository(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => Home()),
        GetPage(name: Routes.OTHER, page: () => Other()),
        GetPage(name: Routes.JOTTINGS, page: () => JottingsPage()),
      ]),
  );
}
