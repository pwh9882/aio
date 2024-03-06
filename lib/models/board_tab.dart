import 'package:aio/models/space_item.dart';

class BoardTab implements SpaceItem {
  @override
  final String id;
  String title;
  String url;
  String? parentFolderId;

  String boardType;

  // boardInfo for parsing the board type
  Map<String, dynamic> boardInfo;

  BoardTab({
    required this.id,
    required this.title,
    required this.url,
    required this.boardType,
    required this.boardInfo,
  });

  @override
  SpaceItemType get type => SpaceItemType.boardTab;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'boardType': boardType,
      'boardInfo': boardInfo,
    };
  }
}
