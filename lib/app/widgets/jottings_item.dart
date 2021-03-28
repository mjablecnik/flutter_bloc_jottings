import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/folder.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/models/note.dart';
import 'package:jottings/app/models/todo.dart';
import 'package:jottings/app/widgets/item_dialog.dart';

_nameIsChanged(previous, current, item) {
  Item prevItem = previous.items.firstWhere((element) => element.id == item.id);
  Item currItem = current.items.firstWhere((element) => element.id == item.id);
  return prevItem.name != currItem.name;
}

class JottingsItem extends StatelessWidget {
  final Item item;

  final JottingsListController controller;

  JottingsItem(this.controller, this.item);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.19,
      child: GestureDetector(
        onTap: () => controller.goInto(item),
        child: _Item(controller, this.item),
      ),
      secondaryActions: <Widget>[
        BlocBuilder<JottingsListController, JottingsListState>(
          buildWhen: (previous, current) => _nameIsChanged(previous, current, item),
          bloc: controller,
          builder: (context, state) => IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () => ItemDialog.getDialog(
              context,
              item: state.items.firstWhere((element) => element.id == item.id).copy(),
              title: "Edit item",
              onSubmit: (item) => controller.editItem(item),
            ),
          ),
        ),
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => controller.removeItem(item),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  _Item(this.controller, this.item);

  final Item item;

  final JottingsListController controller;

  Icon _getIcon(Item item) {
    switch (item.runtimeType) {
      case Folder:
        return Icon(Icons.folder, color: Colors.orange);
      case TodoList:
        return Icon(Icons.list_alt, color: Colors.green);
      case Note:
        return Icon(Icons.notes_rounded, color: Colors.blue);
    }
    return Icon(Icons.error, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _getIcon(item),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: BlocBuilder<JottingsListController, JottingsListState>(
                    buildWhen: (previous, current) => _nameIsChanged(previous, current, item),
                    bloc: controller,
                    builder: (context, state) => Text(
                      state.items.firstWhere((element) => element.id == item.id).name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Handle(
                  delay: const Duration(milliseconds: 100),
                  child: Icon(Icons.drag_indicator),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
