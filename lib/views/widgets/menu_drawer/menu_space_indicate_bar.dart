import 'package:flutter/material.dart';

class MenuSpaceIndicateBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const MenuSpaceIndicateBar({
    required Key key, // TODO: 현재는 debug용
    this.width = 30,
    this.height = 5,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
