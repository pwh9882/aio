import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:aio/models/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class MenuTopBar extends StatelessWidget {
  const MenuTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SpacePageViewController spacePageViewController =
        Get.find<SpacePageViewController>();
    return Container(
      color: context.theme.colorScheme.onSecondary,
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            // menu
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.menu,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          Expanded(
            child: Obx(() => Center(
                  child: Text(
                    style: context.theme.textTheme.titleLarge,
                    spacePageViewController.spaces.isNotEmpty
                        ? spacePageViewController
                            .spaces[
                                spacePageViewController.currentSpaceIndex.value]
                            .name
                        : 'Default Space Name', // 또는 적절한 기본 값
                  ),
                )),
          ),
          IconButton(
            // temp space delete
            onPressed: () {
              spacePageViewController.deleteSpace();
            },
            icon: Icon(
              Icons.edit,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
