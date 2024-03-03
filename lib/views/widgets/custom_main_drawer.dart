import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomMainDrawer extends StatefulWidget {
  const CustomMainDrawer({Key? key}) : super(key: key);

  @override
  CustomMainDrawerState createState() => CustomMainDrawerState();
}

class CustomMainDrawerState extends State<CustomMainDrawer>
    with SingleTickerProviderStateMixin {
  double _offset = 0.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _offset = _animation.value;
        });
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
        // debugPrint("offset: $_offset");
        setState(() {
          _offset =
              math.max(0.0, math.min(_offset + details.delta.dx, screenWidth));
        });
      },
      onHorizontalDragEnd: (details) {
        if (_offset > 10) {
          Navigator.pop(context);
        }
        _animation = Tween<double>(begin: _offset, end: 0.0)
            .animate(_animationController);
        _animationController.forward(from: 0.0);
      },
      child: Transform.translate(
        offset: Offset(_offset, 0.0),
        child: Drawer(
          // Drawer contents go here
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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
