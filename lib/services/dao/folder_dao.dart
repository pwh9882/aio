import 'package:aio/models/folder.dart';
import 'package:aio/models/space_item.dart';
import 'package:aio/services/dao/database_helper.dart';
import 'package:aio/services/dao/tab_dao.dart';

class FolderDAO {
  final dbProvider = DatabaseHelper.instance;

  // Insert
  Future<int> insertFolder(Folder folder) async {
    final db = await dbProvider.database;
    final folderId = await db.insert('folders', folder.toMap());

    // // Insert child folders and their items
    // for (var item in folder.items) {
    //   if (item is Folder) {
    //     await insertFolder(item);
    //   } else if (item is Tab) {
    //     await TabDAO().insertTab(item);
    //   }
    // }

    return folderId;
  }

  // Get a folder by ID and restore its child items
  Future<Folder> getFolderById(String id) async {
    final db = await dbProvider.database;

    // Query the folder
    final List<Map<String, dynamic>> folderMaps = await db.query(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (folderMaps.isEmpty) {
      throw Exception('Folder not found');
    }

    var folderMap = folderMaps.first;
    var itemIds = (folderMap['items'] as List).cast<Map<String, dynamic>>();

    var items = <SpaceItem>[];
    for (var item in itemIds) {
      String itemType = item['type'];
      String itemId = item['reference_id'];

      if (itemType == 'SpaceItemType.tab') {
        var tab = await TabDAO().getTabById(itemId);
        items.add(tab);
      } else if (itemType == 'SpaceItemType.folder') {
        var childFolder = await getFolderById(itemId);
        items.add(childFolder);
      }
    }

    // Return the folder with its items
    return Folder(
      id: folderMap['id'],
      name: folderMap['name'],
      items: items,
    );
  }

  // Update a folder and its items
  Future<int> updateFolder(Folder folder) async {
    final db = await dbProvider.database;

    return await db.update(
      'folders',
      folder.toMap(),
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }

  // Delete a folder and its child items
  Future<void> deleteFolderById(String id) async {
    final db = await dbProvider.database;

    // Get the folder to delete its items
    final folder = await getFolderById(id);

    // Delete each child item
    for (var item in folder.items) {
      if (item.type == SpaceItemType.tab) {
        await TabDAO().deleteTabById(item.id);
      } else if (item.type == SpaceItemType.folder) {
        await deleteFolderById(item.id); // Recursive call for child folders
      }
    }

    // Finally, delete the folder itself
    await db.delete(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Add more methods like updateFolder, deleteFolder, getFolderById, etc.
}
