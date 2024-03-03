import 'package:aio/controllers/theme_controller.dart';
import 'package:aio/themes/app_theme.dart';
import 'package:aio/themes/theme.dart';
import 'package:aio/views/screens/main_screen.dart';
import 'package:aio/views/screens/menu_screen.dart';
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
  final materialTheme = const MaterialTheme(TextTheme());

  // 이 위젯은 애플리케이션의 루트입니다.
  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return GetMaterialApp(
      title: 'AIO',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: themeController.theme,
      home: Scaffold(
        body: isLargeScreen
            ? const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MenuScreen(),
                  ),
                  Expanded(
                    flex: 2,
                    child: MainScreen(),
                  ),
                ],
              )
            : const MainScreen(),
      ),
    );
  }
}
