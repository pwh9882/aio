import 'package:aio/views/widgets/menu_drawer/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuShortcutBar extends StatelessWidget {
  const MenuShortcutBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            // plusbutton
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
