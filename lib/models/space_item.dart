abstract class SpaceItem {
  String get id;
  SpaceItemType get type; // Enum to distinguish between tab and folder

  Map<String, dynamic> toMap();
}

enum SpaceItemType { tab, folder, boardTab }
