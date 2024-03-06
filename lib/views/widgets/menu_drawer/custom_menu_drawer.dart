import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aio/views/screens/menu_screen.dart';

class MenuDrawerController extends GetxController {
  var offset = 0.0.obs;

  void updateOffset(double newOffset) {
    offset.value = newOffset;
  }

  void resetOffset() {
    offset.value = 0.0;
  }
}

class CustomMenuDrawer extends StatefulWidget {
  const CustomMenuDrawer({super.key});

  @override
  CustomMenuDrawerState createState() => CustomMenuDrawerState();
}

class CustomMenuDrawerState extends State<CustomMenuDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final MenuDrawerController controller = Get.put(MenuDrawerController());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        controller.updateOffset(_animation.value);
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: (details) {
        _animationController.stop();
      },
      onHorizontalDragUpdate: (details) {
        double newOffset =
            math.min(0.0, controller.offset.value + details.delta.dx);
        controller.updateOffset(newOffset);
      },
      onHorizontalDragEnd: (details) {
        if (controller.offset.value < -10) {
          Navigator.pop(context);
        }
        _animation = Tween<double>(begin: controller.offset.value, end: 0)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeOut))
          ..addListener(() {
            controller.updateOffset(_animation.value);
          });
        _animationController.forward(from: 0.0);
      },
      child: Obx(
        () => Transform.translate(
          offset: Offset(controller.offset.value, 0.0),
          child: Drawer(
            width: screenWidth * 0.7,
            backgroundColor: Colors.indigo,
            child: const MenuScreen(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
