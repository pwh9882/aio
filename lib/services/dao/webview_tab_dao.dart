import 'package:aio/models/webview_tab.dart';
import 'package:aio/services/dao/database_helper.dart';

class WebviewTabDAO {
  final dbProvider = DatabaseHelper.instance;

  // Insert
  Future<int> insertTab(WebviewTab tab) async {
    final db = await dbProvider.database;
    return await db.insert('tabs', tab.toMap());
  }

  // get tab by id
  Future<WebviewTab> getTabById(String id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tabs',
      where: 'id = ?',
      whereArgs: [id],
    );

    return WebviewTab(
      id: maps[0]['id'],
      name: maps[0]['name'],
      url: maps[0]['url'],
    );
  }

  // Update
  Future<int> updateTab(WebviewTab tab) async {
    final db = await dbProvider.database;
    return await db.update(
      'tabs',
      tab.toMap(),
      where: 'id = ?',
      whereArgs: [tab.id],
    );
  }

  // Delete
  Future<void> deleteTabById(String id) async {
    final db = await dbProvider.database;
    await db.delete(
      'tabs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
