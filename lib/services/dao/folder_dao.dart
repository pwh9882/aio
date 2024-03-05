import 'package:aio/models/folder.dart';
import 'package:aio/models/tab.dart';
import 'package:aio/services/dao/database_helper.dart';
import 'package:aio/services/dao/tab_dao.dart';

class FolderDAO {
  final dbProvider = DatabaseHelper.instance;

  // Insert
  Future<int> insertFolder(Folder folder) async {
    final db = await dbProvider.database;
    return await db.insert('folders', folder.toMap());
  }

  // Read
  Future<List<Folder>> getAllFolders() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('folders');

    return List.generate(maps.length, (i) {
      return Folder(
        id: maps[i]['id'],
        name: maps[i]['name'],
        parentFolderId: maps[i]['parentFolderId'],
      );
    });
  }

  // get folder by id
  Future<Folder> getFolderById(String id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Folder(
      id: maps[0]['id'],
      name: maps[0]['name'],
      parentFolderId: maps[0]['parentFolderId'],
    );
  }

  // get folders by parent folder id
  Future<List<Folder>> getFoldersByParentFolderId(String parentFolderId) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'folders',
      where: 'parentFolderId = ?',
      whereArgs: [parentFolderId],
    );

    return List.generate(maps.length, (i) {
      return Folder(
        id: maps[i]['id'],
        name: maps[i]['name'],
        parentFolderId: maps[i]['parentFolderId'],
      );
    });
  }

  // Update
  Future<int> updateFolder(Folder folder) async {
    final db = await dbProvider.database;
    return await db.update(
      'folders',
      folder.toMap(),
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }

  // Delete
  Future<void> deleteFolderById(String id) async {
    final db = await dbProvider.database;

    // Delete child folders
    final List<Folder> childFolders = await getFoldersByParentFolderId(id);
    for (final folder in childFolders) {
      await deleteFolderById(folder.id);
    }

    // Delete tabs
    final List<Tab> tabs = await TabDAO().getTabsByFolderId(id);
    for (final tab in tabs) {
      await TabDAO().deleteTabById(tab.id);
    }

    // Delete the folder
    await db.delete(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Add more methods like updateFolder, deleteFolder, getFolderById, etc.
}
