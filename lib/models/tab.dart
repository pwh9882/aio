import 'package:aio/models/space_item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Tab implements SpaceItem {
  @override
  final String id;
  String title;
  String url;

  // webview를 활성화했는지 여부, db에 저장되지 않음.
  bool isActivated = false;

  // webview의 key, webview 찾기 위해 사용, db에 저장되지 않음.
  GlobalKey? webViewKey;

  Tab({
    required this.id,
    required this.title,
    required this.url,
  });

  @override
  SpaceItemType get type => SpaceItemType.tab;

  Tab createNewTab({
    String title = 'new Tab',
    String url = 'www.google.com',
  }) {
    var uuid = const Uuid();
    String newTabId = uuid.v4(); // Generates a unique UUID
    return Tab(
      id: newTabId,
      title: title,
      url: url,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': SpaceItemType.tab.toString(), // 'tab' -> 'SpaceItemType.tab
      'title': title,
      'url': url,
    };
  }
}
