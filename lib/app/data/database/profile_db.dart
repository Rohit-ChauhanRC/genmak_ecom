import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/models/profile_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class ProfileDB {
  //
  final tableName = 'profile';

  Future<void> createTable(Database database) async {
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "contact" TEXT,
    "gst" TEXT,
    "customerId" TEXT,
    "picture" BLOB,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
""");
  }

  Future<int> create({
    String? name,
    String? address,
    String? contact,
    String? gst,
    String? customerId,
    Uint8List? picture,
  }) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
        INSERT INTO $tableName (name, address, contact, customerId, picture,gst) VALUES (?,?,?,?,?,?)
      ''',
      [name, address, contact, customerId, picture, gst],
    );
  }

  Future<List<ProfileModel>> fetchAll() async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName 
      ''');

    return products.map((e) => ProfileModel.fromMap(e)).toList();
  }

  Future<ProfileModel> fetchById(int id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE id = ? 
      
      ''', [id]);
    return ProfileModel.fromMap(product.first);
  }

  Future<int> update({
    required int id,
    // String? name,
    // String? gst,
    // String? address,
    // String? contact,
    // String? customerId,
    Uint8List? picture,
  }) async {
    final database = await DataBaseService().database;
    return await database.update(
      tableName,
      {
        // if (name != null) 'name': name,
        // if (gst != null) 'gst': gst,
        // if (address != null) 'address': address,
        // if (contact != null) 'contact': contact,
        // if (customerId != null) 'customerId': customerId,
        if (picture != null) 'picture': picture,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<void> delete({required int id}) async {
    final database = await DataBaseService().database;

    await database.rawDelete('''
  DELETE FROM $tableName WHERE id = ?
''', [id]);
  }
}
