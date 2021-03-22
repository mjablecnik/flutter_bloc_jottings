enum ItemType { Folder, TodoList, Note }

const pathSeparator = "/";
const rootFolderName = "root";
const rootFolderId = "Folder_$rootFolderName";

class BoxStorage {
  static const mainBox = 'jottings';
  static const jottingsListIds = 'jottings_list_ids';
  static const idCounter = 'id_counter';
}


class Texts {
  static const addNoteItem = "Add note";
  static const addTodoListItem = "Add todo list";
  static const addFolderItem = "Add folder";
}
