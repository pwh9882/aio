import 'package:aio/models/tab.dart';
import 'package:aio/services/dao/database_helper.dart';

class TabDAO {
  final dbProvider = DatabaseHelper.instance;

  // Create
  Future<int> createTab(Tab tab) async {
    final db = await dbProvider.database;
    return await db.insert('tabs', tab.toMap());
  }

  // get tab by id
  Future<Tab> getTabById(String id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tabs',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Tab(
      id: maps[0]['id'],
      title: maps[0]['title'],
      url: maps[0]['url'],
      parentFolderId: maps[0]['parentFolderId'],
    );
  }

  // get tabs by folder id
  Future<List<Tab>> getTabsByFolderId(String folderId) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tabs',
      where: 'parentFolderId = ?',
      whereArgs: [folderId],
    );

    return List.generate(maps.length, (i) {
      return Tab(
        id: maps[i]['id'],
        title: maps[i]['title'],
        url: maps[i]['url'],
        parentFolderId: maps[i]['parentFolderId'],
      );
    });
  }

  // Update
  Future<int> updateTab(Tab tab) async {
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
