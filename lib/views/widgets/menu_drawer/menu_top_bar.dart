import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuTopBar extends StatelessWidget {
  const MenuTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              textAlign: TextAlign.center,
              "AIO",
              style: TextStyle(
                color: context.theme.colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            // temp
            onPressed: () {},
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
