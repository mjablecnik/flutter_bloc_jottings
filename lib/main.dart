import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_example/presentation/controllers/basic.dart';
import 'package:getx_example/presentation/controllers/dialog.dart';
import 'package:getx_example/presentation/pages/home.dart';
import 'package:getx_example/presentation/pages/other.dart';

void main() {
  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: "/",
      initialBinding: BindingsBuilder(() {
        Get.put(BasicController());
        Get.create(() => DialogController());
      }),
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/other', page: () => Other()),
      ]),
  );
}
