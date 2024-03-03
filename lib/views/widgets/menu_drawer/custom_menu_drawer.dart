import 'dart:math' as math;
import 'package:aio/views/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class CustomMenuDrawer extends StatefulWidget {
  const CustomMenuDrawer({Key? key}) : super(key: key);

  @override
  CustomMenuDrawerState createState() => CustomMenuDrawerState();
}

class CustomMenuDrawerState extends State<CustomMenuDrawer>
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
          _offset = math.min(0.0, _offset + details.delta.dx);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_offset < -10) {
          Navigator.pop(context);
        }
        _animation =
            Tween<double>(begin: _offset, end: 0).animate(_animationController);
        _animationController.forward(from: 0.0);
      },
      child: Transform.translate(
        offset: Offset(_offset, 0.0),
        child: Drawer(
          // Drawer contents go here
          width: screenWidth * 0.7,
          backgroundColor: Colors.indigo,
          child: const MenuScreen(),
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
