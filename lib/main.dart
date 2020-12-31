import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_example/constants.dart';
import 'package:getx_example/controllers/basic.dart';
import 'package:getx_example/controllers/dialog.dart';
import 'package:getx_example/controllers/jottings.dart';
import 'package:getx_example/pages/home.dart';
import 'package:getx_example/pages/jottings.dart';
import 'package:getx_example/pages/other.dart';

void main() {
  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.create(() => DialogController());
        Get.lazyPut(() => JottingsController(), fenix: true);
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => Home()),
        GetPage(name: Routes.OTHER, page: () => Other()),
        GetPage(name: Routes.JOTTINGS, page: () => JottingsPage()),
      ]),
  );
}
