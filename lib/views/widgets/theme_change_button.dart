import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aio/controllers/theme_controller.dart';

class ThemeChangeButton extends StatelessWidget {
  final themeController = Get.find<ThemeController>();

  ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Get.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        color: Get.isDarkMode ? Colors.white : Colors.grey,
      ),
      onPressed: () {
        // debugPrint('Get.isDarkMode: ${Get.isDarkMode}');
        if (themeController.theme == ThemeMode.dark) {
          themeController.saveTheme(false);
          Get.changeTheme(ThemeData());
          Get.changeThemeMode(ThemeMode.light);
        } else {
          themeController.saveTheme(true);
          themeController.changeTheme(ThemeData.dark());
        }
      },
    );
  }
}
