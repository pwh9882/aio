import 'package:aio/models/folder.dart';
import 'package:aio/models/space.dart';
import 'package:aio/models/space_item.dart';
import 'package:aio/models/tab.dart';
import 'package:aio/services/dao/database_helper.dart';
import 'package:aio/services/dao/folder_dao.dart';
import 'package:aio/services/dao/tab_dao.dart';

class SpaceDAO {
  final dbProvider = DatabaseHelper.instance;

  // Insert a Space instance to the database: 빈 space만 사용해야함.
  Future<int> insertSpace(Space space) async {
    final db = await dbProvider.database;

    // // Insert child items
    // for (var item in space.items) {
    //   if (item is Folder) {
    //     await FolderDAO().insertFolder(item);
    //   } else if (item is Tab) {
    //     await TabDAO().insertTab(item);
    //   }
    // }
    return await db.insert('spaces', space.toMap());
  }

  // Get a Space instance from the database
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

    // 안전한 형 변환
    var items = <SpaceItem>[];
    if (spaceMap['items'] != null && spaceMap['items'] is List) {
      var itemIds = List<Map<String, dynamic>>.from(spaceMap['items']);
      for (var item in itemIds) {
        String itemType = item['type'];
        String itemId = item['reference_id'];

        if (itemType == 'SpaceItemType.tab') {
          var tab = await TabDAO().getTabById(itemId);
          items.add(tab);
        } else if (itemType == 'SpaceItemType.folder') {
          var childFolder = await FolderDAO().getFolderById(itemId);
          items.add(childFolder);
        }
      }
    }

    return Space(id: spaceId, name: spaceMap['name'], items: items);
  }

  // get all spaces
  Future<List<Space>> getAllSpaces() async {
    final db = await dbProvider.database;

    // Get the space records
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

  // Update a space
  Future<int> updateSpace(Space space) async {
    final db = await dbProvider.database;

    return await db.update(
      'spaces',
      space.toMap(),
      where: 'id = ?',
      whereArgs: [space.id],
    );
  }

  // Delete a space
  Future<void> deleteSpaceById(String spaceId) async {
    final db = await dbProvider.database;

    // first delete all child items
    var space = await getSpaceById(spaceId);

    for (var item in space.items) {
      if (item is Folder) {
        await FolderDAO().deleteFolderById(item.id);
      } else if (item is Tab) {
        await TabDAO().deleteTabById(item.id);
      }
    }

    await db.delete(
      'spaces',
      where: 'id = ?',
      whereArgs: [spaceId],
    );
  }

  // Additional methods for creating, updating, and deleting spaces can be added as needed
}
