import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/widgets/jottings_item.dart';

class JottingsList extends StatelessWidget {
  final JottingsListController controller;

  JottingsList(this.controller);

  @override
  Widget build(context) {
    return Obx(() {
      if (controller.items.length > 0) {
        return ImplicitlyAnimatedReorderableList<Rx<Item>>(
          items: controller.items,
          areItemsTheSame: (oldItem, newItem) => oldItem.value.id == newItem.value.id,
          onReorderFinished: (item, from, to, newItems) {
            controller.reorder(from, to);
          },
          itemBuilder: (context, itemAnimation, item, index) {
            item.value.controller = controller;
            return Reorderable(
              key: ValueKey(item),
              builder: (context, dragAnimation, inDrag) {
                return SizeFadeTransition(
                  sizeFraction: 0.5,
                  curve: Curves.easeIn,
                  animation: itemAnimation,
                  child: JottingsItem(item),
                );
              },
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}