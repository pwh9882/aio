import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aio/models/space.dart';
import 'package:aio/services/dao/space_dao.dart';

class SpacePageViewController extends GetxController
    with GetTickerProviderStateMixin {
  // Replace GetSingleTickerProviderStateMixin with GetTickerProviderStateMixin
  late PageController pageViewController;
  late TabController spaceTabController;
  // Add a variable to track if a page transition is in progress
  var isTransitioning = false.obs;

  var showCreateSpacePage = false.obs;

  var currentSpaceIndex = 0.obs;
  var spaces = <Space>[].obs;

  final SpaceDAO spaceDAO = SpaceDAO();

  @override
  void onInit() {
    super.onInit();
    pageViewController = PageController();
    spaceTabController = TabController(length: 3, vsync: this);
    loadSpaces();
  }

  @override
  void onClose() {
    pageViewController.dispose();
    spaceTabController.dispose();
    super.onClose();
  }

  void updateCurrentPageIndex(int index) {
    currentSpaceIndex.value = index;
    spaceTabController.index =
        index >= 0 && index < spaceTabController.length ? index : 0;
  }

  void animateToPage(int index) {
    if (isTransitioning.value) {
      return; // Prevent new transitions if one is ongoing
    }

    isTransitioning.value = true; // Set to true before starting transition
    updateCurrentPageIndex(index);
    pageViewController
        .animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    )
        .then((_) {
      isTransitioning.value = false;
    }); // Set back to false after transition
  }

  Future<void> loadSpaces() async {
    var loadedSpaces = await spaceDAO.getAllSpaces();
    spaces.assignAll(loadedSpaces);
    // Update TabController length based on the number of spaces loaded
    spaceTabController = TabController(length: spaces.length, vsync: this);
  }

  void addCreateSpacePage() {
    showCreateSpacePage.value = true;
    spaces.add(Space.createEmptySpace(newSpaceName: "Create New Space"));
    spaceTabController = TabController(length: spaces.length, vsync: this);
    animateToPage(spaces.length - 1);
  }

  void completeCreateSpacePage() {
    showCreateSpacePage.value = false;
  }

  void cancelCreateSpacePage() {
    animateToPage(spaces.length - 2);
    showCreateSpacePage.value = false;
    spaces.removeLast();
    spaceTabController = TabController(length: spaces.length, vsync: this);
  }

  // create a new empty space
  // Update createSpace to include a name parameter
  Future<void> createSpace(Space newSpace) async {
    spaceDAO.insertSpace(newSpace);
    // spaceTabController = TabController(length: spaces.length, vsync: this);
    completeCreateSpacePage();
    currentSpaceIndex.value = spaces.length - 1;
  }

  // edit current space
  Future<void> editSpace() async {
    debugPrint('editSpace');
    var space = spaces[currentSpaceIndex.value];
    spaceDAO.updateSpace(space);
  }

  Future<void> deleteSpace() async {
    debugPrint('deleteSpace');
    var space = spaces[currentSpaceIndex.value];
    await spaceDAO.deleteSpaceById(space.id);
    spaces.removeAt(currentSpaceIndex.value);

    if (spaces.isNotEmpty) {
      int newIndex;
      if (currentSpaceIndex.value < spaces.length) {
        // 삭제된 공간이 마지막이 아니면 현재 인덱스 유지
        newIndex = currentSpaceIndex.value;
      } else {
        // 삭제된 공간이 마지막 공간이면 왼쪽 공간으로 이동
        newIndex = spaces.length - 1;
      }
      currentSpaceIndex.value = newIndex;
      spaceTabController = TabController(length: spaces.length, vsync: this);
      animateToPage(newIndex);
    } else {
      // 공간이 하나도 없으면 새 공간을 생성
      var defaultSpace = Space.createEmptySpace(newSpaceName: "default space");
      await createSpace(defaultSpace);
    }
  }
}
