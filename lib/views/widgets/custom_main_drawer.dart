import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawerController extends GetxController {
  var offset = 0.0.obs;

  void updateOffset(double newOffset) {
    offset.value = newOffset;
  }

  void resetOffset() {
    offset.value = 0.0;
  }
}

class CustomMainDrawer extends StatefulWidget {
  const CustomMainDrawer({super.key});

  @override
  CustomMainDrawerState createState() => CustomMainDrawerState();
}

class CustomMainDrawerState extends State<CustomMainDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final MainDrawerController controller = Get.put(MainDrawerController());

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
        double newOffset = math.max(0.0,
            math.min(controller.offset.value + details.delta.dx, screenWidth));
        controller.updateOffset(newOffset);
      },
      onHorizontalDragEnd: (details) {
        if (controller.offset.value > 10) {
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
            width: screenWidth,
            child: const Column(
              children: [
                Text('Item 1'),
                Text('Item 2'),
                Text('Item 3'),
              ],
            ),
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
