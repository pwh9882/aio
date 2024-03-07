import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:aio/views/widgets/menu_drawer/menu_shortcut_bar.dart';
import 'package:aio/views/widgets/menu_drawer/menu_space_indicate_bar.dart';
import 'package:aio/views/widgets/menu_drawer/menu_top_bar.dart';
import 'package:aio/views/widgets/menu_drawer/space_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SpacePageViewController());

    return Scaffold(
        backgroundColor: context.theme.colorScheme.primaryContainer,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MenuTopBar(),
            const Expanded(child: SpacePageView()),
            MenuSpaceIndicateBar(key: GlobalKey()),
            const MenuShortcutBar(),
          ],
        ));
  }
}
