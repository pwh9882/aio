import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:aio/views/widgets/menu_drawer/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SampleItem { itemZero, itemOne, itemTwo, itemThree }

class MenuShortcutBarController extends GetxController {
  var selectedItem = SampleItem.itemZero.obs;

  void updateSelectedItem(SampleItem item) {
    selectedItem.value = item;
  }
}

class MenuShortcutBar extends StatelessWidget {
  const MenuShortcutBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MenuShortcutBarController controller =
        Get.put(MenuShortcutBarController());
    final SpacePageViewController spacePageViewController =
        Get.find<SpacePageViewController>();
    return Container(
      color: context.theme.colorScheme.onSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            // bookmark
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.bookmark_outlined,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          IconButton(
            // history
            onPressed: () {
              // TODO: implement onPressed
            },
            icon: Icon(
              Icons.history_outlined,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          ThemeChangeButton(),
          IconButton(
            // settings
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          PopupMenuButton<SampleItem>(
            icon: Icon(
              Icons.add_circle_outline,
              color: context.theme.colorScheme.onBackground,
            ),
            initialValue: controller.selectedItem.value,
            onSelected: (SampleItem item) {
              controller.updateSelectedItem(item);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: const Text('Create New Space'),
                onTap: () => {
                  if (!spacePageViewController.showCreateSpacePage.value)
                    {
                      debugPrint('Create New Space'),
                      spacePageViewController.addCreateSpacePage(),
                    }
                },
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: const Text('Create New Folder'),
                onTap: () => {
                  debugPrint('Create New Folder'),
                },
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: const Text('Create New Tab'),
                onTap: () => {
                  debugPrint('Create New Tab'),
                },
              ),
            ],
            offset: const Offset(0, -165), // 팝업 메뉴의 위치를 위로 조정
            elevation: 4.0, // 팝업 메뉴에 그림자 효과를 추가
          ),
        ],
      ),
    );
  }
}
