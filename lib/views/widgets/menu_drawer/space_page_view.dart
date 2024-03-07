import 'package:aio/controllers/space_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacePageView extends StatelessWidget {
  const SpacePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpacePageViewController controller =
        Get.find<SpacePageViewController>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: controller.pageViewController,
          onPageChanged: controller.updateCurrentPageIndex,
          children: <Widget>[
            Center(
              child: Text('First Page', style: textTheme.titleLarge),
            ),
            Center(
              child: Text('Second Page', style: textTheme.titleLarge),
            ),
            Center(
              child: Text('Third Page', style: textTheme.titleLarge),
            ),
          ],
        ),
        PageIndicator(controller: controller),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.controller});

  final SpacePageViewController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() => IconButton(
                splashRadius: 16.0,
                padding: EdgeInsets.zero,
                onPressed: controller.currentPageIndex.value == 0
                    ? null
                    : () => controller
                        .animateToPage(controller.currentPageIndex.value - 1),
                icon: const Icon(
                  Icons.arrow_left_rounded,
                  size: 32.0,
                ),
              )),
          TabPageSelector(
            controller: controller.tabController,
            color: colorScheme.background,
            selectedColor: colorScheme.primary,
          ),
          Obx(() => IconButton(
                splashRadius: 16.0,
                padding: EdgeInsets.zero,
                onPressed: controller.currentPageIndex.value == 2
                    ? null
                    : () => controller
                        .animateToPage(controller.currentPageIndex.value + 1),
                icon: const Icon(
                  Icons.arrow_right_rounded,
                  size: 32.0,
                ),
              )),
        ],
      ),
    );
  }
}
