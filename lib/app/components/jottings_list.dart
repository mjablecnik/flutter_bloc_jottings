import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:jottings/app/controllers/jottings_list_controller.dart';
import 'package:jottings/app/models/item.dart';
import 'package:jottings/app/components/jottings_item.dart';

class JottingsList extends StatelessWidget {
  final JottingsListController controller;

  JottingsList(this.controller);

  @override
  Widget build(context) {
    return BlocBuilder<JottingsListController, JottingsListState>(
      buildWhen: (previous, current) => previous.items.length != current.items.length,
      bloc: controller,
      builder: (context, state) {
        if (state.items.length > 0) {
          return ImplicitlyAnimatedReorderableList<Item>(
            items: state.items,
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, newItems) {
              controller.reorder(from!, to);
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item),
                builder: (context, dragAnimation, inDrag) {
                  return SizeFadeTransition(
                    sizeFraction: 0.5,
                    curve: Curves.easeIn,
                    animation: itemAnimation,
                    child: JottingsItem(controller, item),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
