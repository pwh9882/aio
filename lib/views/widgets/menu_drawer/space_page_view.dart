import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacePageViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController pageViewController;
  late TabController tabController;
  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageViewController = PageController();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    pageViewController.dispose();
    tabController.dispose();
    super.onClose();
  }

  void updateCurrentPageIndex(int index) {
    currentPageIndex.value = index;
    tabController.index = index;
  }

  void animateToPage(int index) {
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    updateCurrentPageIndex(index);
  }
}

class SpacePageView extends StatelessWidget {
  const SpacePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpacePageViewController controller =
        Get.put(SpacePageViewController());
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
