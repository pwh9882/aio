import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:aio/views/widgets/menu_drawer/create_space_page.dart';
import 'package:aio/views/widgets/menu_drawer/space_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacePageView extends StatelessWidget {
  const SpacePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpacePageViewController controller =
        Get.find<SpacePageViewController>();

    return Obx(() {
      var showCreateSpacePage = controller.showCreateSpacePage.value;

      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: controller.pageViewController,
            onPageChanged: controller.updateCurrentPageIndex,
            children: controller.spaces.map((space) {
              if (showCreateSpacePage && space.name == "Create New Space") {
                return Center(
                  child: CreateSpacePage(
                    onConfirm: (name) {
                      space.name = name;
                      controller.createSpace(space);
                    },
                    onCancel: () {
                      controller.cancelCreateSpacePage();
                    },
                  ),
                );
              } else {
                return const SpaceItemsListView();
              }
            }).toList(),
          ),
          PageIndicator(controller: controller),
        ],
      );
    });
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.controller});

  final SpacePageViewController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() => IconButton(
                splashRadius: 16.0,
                padding: EdgeInsets.zero,
                onPressed: controller.currentSpaceIndex.value == 0 ||
                        controller.spaceTabController.length <= 1
                    ? null
                    : () => controller
                        .animateToPage(controller.currentSpaceIndex.value - 1),
                icon: const Icon(
                  Icons.arrow_left_rounded,
                  size: 32.0,
                ),
              )),
          TabPageSelector(
            controller: controller.spaceTabController,
            color: colorScheme.background,
            selectedColor: colorScheme.primary,
          ),
          Obx(() => IconButton(
                splashRadius: 16.0,
                padding: EdgeInsets.zero,
                onPressed: controller.currentSpaceIndex.value ==
                            controller.spaceTabController.length - 1 ||
                        controller.spaceTabController.length <= 1
                    ? null
                    : () => controller
                        .animateToPage(controller.currentSpaceIndex.value + 1),
                icon: const Icon(
                  Icons.arrow_right_rounded,
                  size: 32.0,
                ),
              )),
        ],
      ),
    );
  }
}
