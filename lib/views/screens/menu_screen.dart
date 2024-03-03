import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.colorScheme.primaryContainer,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Menuasdf"),
          ],
        ));
  }
}
