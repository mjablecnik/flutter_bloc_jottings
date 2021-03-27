import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/pages/main_page.dart';

enum Status { loading, success, failure }

class JottingsListState {
  const JottingsListState._(this.currentFolder, {
    this.status = Status.loading,
    this.items = const <Item>[],
  });

  const JottingsListState.loading(Folder currentFolder) : this._(currentFolder);

  const JottingsListState.success(Folder currentFolder, List<Item> items)
      : this._(currentFolder, status: Status.success, items: items);

  const JottingsListState.failure(Folder currentFolder)
      : this._(currentFolder, status: Status.failure);

  final Status status;
  final List<Item> items;
  final Folder currentFolder;
}

class JottingsListController extends Cubit<JottingsListState> {

  Box _box = Hive.box(BoxStorage.jottingsListIds);

  String _getCurrentFolderListKey() => "folder_list_ids:${state.currentFolder.id}";

  JottingsListController(currentFolder) : super(JottingsListState.loading(currentFolder)) {
    load();
  }

  addItem(Item item) async {
    //item.dirPath = [...state.currentFolder.dirPath!, state.currentFolder.name];
    //emit(JottingsListState.success(state.currentFolder, [...state.items, item]));
    //item.save();
    //state.currentFolder.itemIds.add(item.id!);
    //state.currentFolder.save();
    //_updateListIds();
  }

  _removeFolderItems(Folder folder) async {
    //for (String itemId in folder.itemIds) {
    //  if (Item.getTypeFromId(itemId) == ItemType.Folder) {
    //    var openedFolderController = _openedFolders.where((element) => element.folder.id == itemId);
    //    Folder item = openedFolderController.isEmpty ? Folder.load(itemId)! : openedFolderController.first.folder;
    //    this._removeFolderItems(item);
    //    item.delete();
    //  } else {
    //    Item.load(itemId)!.delete();
    //  }
    //}
  }

  removeItem(Item item) {
    //this.items.remove(item);
    //if (item.runtimeType == Folder) {
    //  _removeFolderItems(item as Folder);
    //  _openedFolders.removeWhere((element) => element.folder.id == item.id);
    //}
    //_currentFolder.itemIds.remove(item.id);
    //_currentFolder.save();
    //_updateListIds();
  }

  editItem(Item item) {
    //int index = state.items.indexWhere((element) => element.id == item.id);
    //state.items.removeAt(index);
    //state.items.insert(index, item);

    item.save();
    emit(JottingsListState.success(state.currentFolder, [...state.items]));
  }

  reorder(int oldIndex, int newIndex) {
    var row = state.items.removeAt(oldIndex);
    state.items.insert(newIndex, row);
    _updateListIds();
  }

  _updateListIds() {
    var idsList = state.items.map((e) => e.id).toList();
    _box.put(_getCurrentFolderListKey(), idsList);
  }

  Folder _loadCurrentFolder() {
    Folder? folder = Folder.load(state.currentFolder.id!);

    if (folder != null) {
      return folder;
    } else {
      return Folder.root();
    }
  }

  load() {
    List<Item> items = [];
    Folder currentFolder = _loadCurrentFolder();

    List<String> jottingsListIds = List.from(_box.get(_getCurrentFolderListKey()) ?? []);
    currentFolder.itemIds = jottingsListIds;
    for (var id in jottingsListIds) {
      items.add(Item.load(id)!);
    }
    emit(JottingsListState.success(currentFolder, items));
  }

  goInto(Item item) {
    //if (item.runtimeType == Folder) {
    //  late var folder;
    //  var folderList = _openedFolders.where((e) => e.id == item.id);
    //  if (folderList.isEmpty) {
    //    folder = JottingsListController(item);
    //    _openedFolders.add(folder);
    //  } else {
    //    folder = folderList.first;
    //  }
    //  Get.to(
    //    () => JottingsListPage(folder!),
    //    preventDuplicates: false,
    //    duration: Duration(seconds: 0),
    //  );
    //}
  }
}
