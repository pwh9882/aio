import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMenuScreen extends StatelessWidget {
  const ListMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.colorScheme.primary,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Menuasdf"),
          ],
        ));
  }
}
