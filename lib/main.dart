import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/domain/adapters/note.dart';
import 'package:getx_example/domain/services/jotting.dart';
import 'package:getx_example/presentation/controllers/basic.dart';
import 'package:getx_example/presentation/controllers/dialog.dart';
import 'package:getx_example/presentation/controllers/jottings.dart';
import 'package:getx_example/presentation/pages/home.dart';
import 'package:getx_example/presentation/pages/jottings.dart';
import 'package:getx_example/presentation/pages/other.dart';

void main() {
  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.create(() => DialogController());
        Get.lazyPut(() => JottingsController(), fenix: true);
        Get.lazyPut(() => NoteAdapter(), fenix: true);
        Get.lazyPut(() => JottingService(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => Home()),
        GetPage(name: Routes.OTHER, page: () => Other()),
        GetPage(name: Routes.JOTTINGS, page: () => JottingsPage()),
      ]),
  );
}
