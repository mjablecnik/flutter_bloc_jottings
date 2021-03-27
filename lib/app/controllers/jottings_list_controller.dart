import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jottings/app/common/constants.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum Status { loading, success, failure }

class JottingsListState {
  const JottingsListState._({
    this.folder,
    this.status = Status.loading,
    this.items = const <Item>[],
  });

  const JottingsListState.loading() : this._();

  const JottingsListState.success(Folder folder, List<Item> items)
      : this._(folder: folder, status: Status.success, items: items);

  const JottingsListState.failure() : this._(status: Status.failure);

  final Status status;
  final List<Item> items;
  final Folder? folder;
}

class JottingsListController extends Cubit<JottingsListState> {
  Box _box = Hive.box(BoxStorage.jottingsListIds);

  final folderId;

  String _getCurrentFolderListKey() => "folder_list_ids:$folderId";

  JottingsListController(this.folderId) : super(JottingsListState.loading()) {
    load(folderId);
  }

  addItem(Item item) async {
    item.dirPath = [...state.folder!.dirPath!, state.folder!.name];
    List<String> itemIds = [...state.folder!.itemIds, item.id!];

    emit(JottingsListState.success(
      state.folder!.copyWith(itemIds: itemIds),
      [...state.items, item],
    ));

    item.save();
    state.folder!.save();
    _updateListIds();
  }

  _removeFolderItems(Folder folder) async {
    for (String itemId in folder.itemIds) {
      if (Item.getTypeFromId(itemId) == ItemType.Folder) {
        Folder item = Folder.load(itemId)!;
        this._removeFolderItems(item);
        item.delete();
      } else {
        Item.load(itemId)!.delete();
      }
    }
  }

  removeItem(Item item) {
    List<Item> items = List.from(state.items)..remove(item);
    List<String> itemIds = state.folder!.itemIds..remove(item.id);

    if (item.runtimeType == Folder) {
      _removeFolderItems(item as Folder);
    }

    Folder folder = state.folder!.copyWith(itemIds: itemIds);
    emit(JottingsListState.success(folder, items));

    state.folder!.save();
    _updateListIds();
  }

  editItem(Item item) {
    //int index = state.items.indexWhere((element) => element.id == item.id);
    //state.items.removeAt(index);
    //state.items.insert(index, item);

    item.save();
    emit(JottingsListState.success(state.folder!, [...state.items]));
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

  Folder _loadFolder(String id) {
    Folder? folder = Folder.load(id);

    if (folder != null) {
      return folder;
    } else {
      return Folder.root();
    }
  }

  load(String folderId) {
    List<Item> items = [];
    Folder currentFolder = _loadFolder(folderId);

    List<String> jottingsListIds = List.from(_box.get(_getCurrentFolderListKey()) ?? []);
    currentFolder.itemIds = jottingsListIds;
    for (var id in jottingsListIds) {
      items.add(Item.load(id)!);
    }
    emit(JottingsListState.success(currentFolder, items));
  }

  goInto(Item item) {
    if (item.runtimeType == Folder) {
      Modular.to.pushNamed('/jottingsList/${item.id}/');
    }
  }
}
