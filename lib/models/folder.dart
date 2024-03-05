import 'package:aio/models/space_item.dart';

class Folder implements SpaceItem {
  @override
  final String id;
  String name;
  String? parentFolderId;

  Folder({required this.id, required this.name, this.parentFolderId});

  @override
  SpaceItemType get type => SpaceItemType.folder;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentFolderId': parentFolderId,
    };
  }
}
