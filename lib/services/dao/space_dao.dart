import 'package:aio/models/space.dart';
import 'package:aio/models/space_item.dart';
import 'package:aio/services/dao/database_helper.dart';
import 'package:aio/services/dao/folder_dao.dart';
import 'package:aio/services/dao/tab_dao.dart';
import 'package:sqflite/sql.dart';

class SpaceDAO {
  final dbProvider = DatabaseHelper.instance;

  // Insert a Space instance to the database
  Future<void> insertSpace(Space space) async {
    final db = await dbProvider.database;
    final batch = db.batch();

    // Update or insert the space record
    batch.insert(
      'spaces',
      {'id': space.id, 'name': space.name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Clear existing items for this space
    batch.delete(
      'space_items',
      where: 'space_id = ?',
      whereArgs: [space.id],
    );

    // Insert new items
    var position = 0;
    for (var item in space.items) {
      batch.insert(
        'space_items',
        {
          'space_id': space.id,
          'type': item.type.toString(),
          'reference_id': item.id,
          'position': position++,
        },
      );
    }

    await batch.commit();
  }

  // Get a Space instance from the database
  Future<Space> getSpaceById(String spaceId) async {
    final db = await dbProvider.database;

    // Get the space record
    final List<Map<String, dynamic>> spaceMaps = await db.query(
      'spaces',
      where: 'id = ?',
      whereArgs: [spaceId],
    );

    if (spaceMaps.isEmpty) {
      throw Exception('Space not found');
    }

    final spaceMap = spaceMaps.first;

    // Get the space items
    final List<Map<String, dynamic>> itemMaps = await db.query(
      'space_items',
      where: 'space_id = ?',
      orderBy: 'position',
      whereArgs: [spaceId],
    );

    var items = <SpaceItem>[];
    for (var map in itemMaps) {
      if (map['type'] == 'SpaceItemType.tab') {
        var tab = await TabDAO().getTabById(map['reference_id']);
        items.add(tab);
      } else if (map['type'] == 'SpaceItemType.folder') {
        var folder = await FolderDAO().getFolderById(map['reference_id']);
        items.add(folder);
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
    for (var spaceMap in spaceMaps) {
      var space = await getSpaceById(spaceMap['id']);
      spaces.add(space);
    }

    return spaces;
  }

  // Delete a space
  Future<void> deleteSpaceById(String spaceId) async {
    final db = await dbProvider.database;

    await db.delete(
      'spaces',
      where: 'id = ?',
      whereArgs: [spaceId],
    );

    await db.delete(
      'space_items',
      where: 'space_id = ?',
      whereArgs: [spaceId],
    );
  }

  // Additional methods for creating, updating, and deleting spaces can be added as needed
}
