import 'package:get/get.dart';
import 'package:getx_example/domain/entities/item.dart';
import 'package:getx_example/domain/entities/note.dart';

class NoteAdapter extends GetxService {

  Item create(Item item) {
    return item;
  }
}