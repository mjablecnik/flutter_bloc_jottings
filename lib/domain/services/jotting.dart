import 'package:get/get.dart';
import 'package:getx_example/domain/adapters/note.dart';
import 'package:getx_example/domain/entities/item.dart';

abstract class IJottingService {
  Future<Item> create(Item item);

  List<Item> getList();

  Item editItem();

  Item getItem();
}

class JottingService extends GetxService implements IJottingService {

  NoteAdapter _noteAdapter;

  @override
  void onInit() {
    super.onInit();
    _noteAdapter = Get.find<NoteAdapter>();
  }

  @override
  Future<Item> create(Item item) async {
    return Future.delayed(Duration(seconds: 1), () => _noteAdapter.create(item));
  }

  @override
  editItem() {
    // TODO: implement editItem
    throw UnimplementedError();
  }

  @override
  getItem() {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }
}
