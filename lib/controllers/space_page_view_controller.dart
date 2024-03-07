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
