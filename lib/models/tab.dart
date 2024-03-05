import 'package:aio/models/space_item.dart';
import 'package:flutter/material.dart';

class Tab implements SpaceItem {
  @override
  final String id;
  String title;
  String url;
  String? parentFolderId;

  // webview를 활성화했는지 여부, db에 저장되지 않음.
  bool isActivated = false;

  // webview의 key, webview 찾기 위해 사용, db에 저장되지 않음.
  GlobalKey? webViewKey;

  Tab(
      {required this.id,
      required this.title,
      required this.url,
      this.parentFolderId});

  @override
  SpaceItemType get type => SpaceItemType.tab;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'parentFolderId': parentFolderId,
    };
  }
}
