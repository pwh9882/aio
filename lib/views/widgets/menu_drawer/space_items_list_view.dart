import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpaceItemsListView extends StatelessWidget {
  const SpaceItemsListView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final SpacePageViewController controller =
        Get.find<SpacePageViewController>();

    return Obx(() {
      final spaceItems = controller.spaces[index].items;
      final selectedItemId = controller.spaces[index].lastSelectedItem?.id;

      return ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          controller.reorderSpaceItems(oldIndex, newIndex);
        },
        children: [
          for (final item in spaceItems)
            GestureDetector(
              key: ValueKey(item.id),
              onTap: () => controller.selectSpaceItem(index, item),
              child: Card(
                key: ValueKey(item.id),
                color: item.id == selectedItemId
                    ? Theme.of(context).colorScheme.surfaceVariant
                    : null,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.deleteSpaceItem(spaceItems.indexOf(item));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
