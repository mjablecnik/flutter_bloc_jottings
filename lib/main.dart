import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home.dart';

void main() {
  runApp(
    GetMaterialApp(
      //home: Home(),
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/other', page: () => Other()),
      ]
    ),
  );
}
