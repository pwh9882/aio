abstract class SpaceItem {
  String get id;
  SpaceItemType get type; // Enum to distinguish between tab and folder
}

enum SpaceItemType { tab, folder, boardTab }
