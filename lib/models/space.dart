import 'package:aio/models/space_item.dart';
import 'package:uuid/uuid.dart';

class Space {
  String id;
  String name; // Added name property
  List<SpaceItem> items;

  // db에 저장되지 않음, 마지막으로 선택된 아이템
  SpaceItem? lastSelectedItem;

  Space(
      {required this.id,
      required this.name,
      required this.items}); // Updated constructor

  Space createEmptySpace({String newSpaceName = "default space"}) {
    var uuid = const Uuid();
    String newSpaceId = uuid.v4(); // Generates a unique UUID

    return Space(id: newSpaceId, name: newSpaceName, items: []);
  }

  // Convert Space instance to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name, // Added name field
      'items': items.map((item) {
        return {
          'type': item.type.toString(),
          'reference_id': item.id,
        };
      }).toList(),
    };
  }
}
