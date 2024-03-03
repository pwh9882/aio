import 'package:aio/controllers/list_drawer_controller.dart';
import 'package:aio/controllers/theme_controller.dart';
import 'package:aio/themes/app_theme.dart';
import 'package:aio/views/screens/list_menu_screen.dart';
import 'package:aio/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put<ListDrawerController>(ListDrawerController());

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
      home: const MyListDrawer(),
    );
  }
}

class MyListDrawer extends GetView<ListDrawerController> {
  const MyListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    isLargeScreen ? controller.zoomDrawerController.close?.call() : null;
    return GetBuilder<ListDrawerController>(
      builder: (_) => ZoomDrawer(
        // style: DrawerStyle.defaultStyle,
        controller: _.zoomDrawerController,
        menuScreen: isLargeScreen ? Container() : const ListMenuScreen(),
        mainScreen: isLargeScreen
            ? const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListMenuScreen(),
                  ),
                  Expanded(
                    flex: 2,
                    child: MainScreen(),
                  ),
                ],
              )
            : const MainScreen(),
        // borderRadius: 24.0,
        showShadow: false,
        // angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        dragOffset: MediaQuery.of(context).size.width * 0.5,
        mainScreenTapClose: true,
        // mainScreenScale: 0,
        disableDragGesture: isLargeScreen ? true : false,
        closeCurve: Curves.easeInOut,
        // openCurve: Curves.easeInOut,
        // shrinkMainScreen: true,
        drawerStyleBuilder:
            (context, animationValue, slideWidth, menuScreen, mainScreen) {
          double slide = slideWidth * animationValue - 50 * animationValue;
          double menuScreenOffset =
              0; // Adjust the value as neededide width by 50

          return Stack(
            children: [
              Transform.translate(
                offset: Offset(menuScreenOffset, 0),
                child: menuScreen,
              ),
              Transform(
                transform: Matrix4.identity()..translate(slide),
                alignment: Alignment.center,
                child: mainScreen,
              ),
            ],
          );
        },
      ),
    );
  }
}
