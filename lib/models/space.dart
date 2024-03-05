import 'package:aio/models/space_item.dart';
import 'package:uuid/uuid.dart';

class Space {
  String id;
  String name; // Added name property
  List<SpaceItem> items;

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
    var position = 0;
    return {
      'id': id,
      'name': name, // Added name field
      'items': items.map((item) {
        return {
          'space_id': id,
          'type': item.type.toString(),
          'reference_id': item.id,
          'position': position++,
        };
      }).toList(),
    };
  }
}
