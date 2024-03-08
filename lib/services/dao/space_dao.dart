import 'dart:convert';
import 'package:aio/models/space.dart';
import 'package:aio/models/space_item.dart';
import 'package:aio/models/folder.dart';
import 'package:aio/models/tab.dart';
import 'package:aio/services/dao/database_helper.dart';
import 'package:aio/services/dao/folder_dao.dart';
import 'package:aio/services/dao/tab_dao.dart';

class SpaceDAO {
  final DatabaseHelper dbProvider = DatabaseHelper.instance;

  // Insert a new Space
  Future<int> insertSpace(Space space) async {
    final db = await dbProvider.database;
    return await db.insert('spaces', space.toMap());
  }

  // Get a Space by ID
  Future<Space> getSpaceById(String spaceId) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> spaceMaps = await db.query(
      'spaces',
      where: 'id = ?',
      whereArgs: [spaceId],
    );

    if (spaceMaps.isEmpty) {
      throw Exception('Space not found');
    }

    final spaceMap = spaceMaps.first;
    var items = <SpaceItem>[];
    if (spaceMap['items'] != null) {
      var itemData = jsonDecode(spaceMap['items']) as List;
      for (var item in itemData) {
        String itemType = item['type'];
        String itemId = item['reference_id'];

        if (itemType == 'SpaceItemType.tab') {
          var tab = await TabDAO().getTabById(itemId);
          items.add(tab);
        } else if (itemType == 'SpaceItemType.folder') {
          var folder = await FolderDAO().getFolderById(itemId);
          items.add(folder);
        }
        // Add other SpaceItem types here
      }
    }

    return Space(id: spaceId, name: spaceMap['name'], items: items);
  }

  // Get all Spaces
  Future<List<Space>> getAllSpaces() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> spaceMaps = await db.query('spaces');

    var spaces = <Space>[];
    if (spaceMaps.isEmpty) {
      // Add a default empty space if spaces is empty
      var defaultSpace = Space(id: 'default', name: 'Default Space', items: []);
      await insertSpace(defaultSpace);
      spaces.add(defaultSpace);
    } else {
      for (var spaceMap in spaceMaps) {
        var space = await getSpaceById(spaceMap['id']);
        spaces.add(space);
      }
    }

    return spaces;
  }

  // Update a Space
  Future<int> updateSpace(Space space) async {
    final db = await dbProvider.database;
    return await db.update(
      'spaces',
      space.toMap(),
      where: 'id = ?',
      whereArgs: [space.id],
    );
  }

  // Delete a Space by ID
  Future<void> deleteSpaceById(String spaceId) async {
    final db = await dbProvider.database;
    var space = await getSpaceById(spaceId);

    for (var item in space.items) {
      if (item is Folder) {
        await FolderDAO().deleteFolderById(item.id);
      } else if (item is Tab) {
        await TabDAO().deleteTabById(item.id);
      }
      // Handle other SpaceItem types here
    }

    await db.delete(
      'spaces',
      where: 'id = ?',
      whereArgs: [spaceId],
    );
  }

  // Additional methods for SpaceDAO can be added here
}
