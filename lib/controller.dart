import 'package:get/get.dart';

class Controller extends GetxController{
  var count = 0.obs;
  List<String> testList = <String>["test1", "test2"].obs;

  increment() => count++;

  addToList(String item) {

    print("adding: " + item);
    testList.add(item);
  }
}