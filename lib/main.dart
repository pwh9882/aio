import 'package:aio/controllers/theme_controller.dart';
import 'package:aio/themes/app_theme.dart';
import 'package:aio/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  // 이 위젯은 애플리케이션의 루트입니다.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AIO',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.theme,
      home: const MainScreen(), // MyListDrawer()
    );
  }
}
