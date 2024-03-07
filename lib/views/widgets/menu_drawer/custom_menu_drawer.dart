import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aio/views/screens/menu_screen.dart';

class CustomMenuDrawerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  RxDouble offset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateOffset(double newOffset) {
    offset.value = newOffset;
  }

  void resetOffset() {
    offset.value = 0.0;
  }

  void handleDragStart(DragStartDetails details) {
    _animationController.stop();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    double newOffset = math.min(0.0, offset.value + details.delta.dx);
    updateOffset(newOffset);
    // debugPrint('offset: $offset');
  }

  void handleDragEnd(DragEndDetails details, BuildContext context) {
    if (offset.value < -10) {
      Navigator.pop(context);
    }
    _animation = Tween<double>(begin: offset.value, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        updateOffset(_animation.value);
      });
    _animationController.forward(from: 0.0);
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class CustomMenuDrawer extends StatelessWidget {
  const CustomMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomMenuDrawerController());
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: controller.handleDragStart,
      onHorizontalDragUpdate: controller.handleDragUpdate,
      onHorizontalDragEnd: (details) =>
          controller.handleDragEnd(details, context),
      child: Obx(
        () => Transform.translate(
          offset: Offset(controller.offset.value, 0),
          child: Drawer(
            width: screenWidth * 0.7,
            backgroundColor: Colors.indigo,
            child: const MenuScreen(),
          ),
        ),
      ),
    );
  }
}
