import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class ProductDB {
  //
  final tableName = 'products';

  Future<void> createTable(Database database) async {
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "quantity" TEXT,
    "description" TEXT,
    "picture" BLOB,
    "count" INTEGER,
    "active" INTEGER,
    "gst" TEXT,
    "hsnCode" TEXT,
    "discount" TEXT,
    "unit" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
""");
  }

  Future<int> create({
    required String name,
    required String weight,
    required String price,
    String? quantity,
    String? description,
    Uint8List? picture,
    int? count,
    int? active,
    String? gst,
    String? discount,
    String? hsnCode,
    String? unit,
  }) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
        INSERT INTO $tableName (name,weight,price,quantity,description, picture,count,active,gst,discount,hsnCode,unit) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
      ''',
      [
        name,
        weight,
        price,
        quantity,
        description,
        picture,
        count,
        active,
        gst,
        discount,
        hsnCode,
        unit
      ],
    );
  }

  Future<List<ProductModel>> fetchAll() async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName 
      ''');

    return products.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<List<ProductModel>> fetchByName(String name) async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName WHERE name = ?
      ''', [name]);

    return products.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<ProductModel> fetchById(int id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE id = ? 
      
      ''', [id]);
    return ProductModel.fromMap(product.first);
  }

  Future<int> update({
    required int id,
    String? name,
    String? weight,
    String? price,
    String? quantity,
    String? description,
    Uint8List? picture,
    int? count,
    int? active,
    String? gst,
    String? discount,
    String? hsnCode,
    String? unit,
  }) async {
    final database = await DataBaseService().database;
    return await database.update(
      tableName,
      {
        if (name != null) 'name': name,
        if (weight != null) 'weight': weight,
        if (price != null) 'price': price,
        if (quantity != null) 'quantity': quantity,
        if (description != null) 'description': description,
        if (picture != null) 'picture': picture,
        if (count != null) 'count': count,
        if (active != null) 'active': active,
        if (gst != null) 'gst': gst,
        if (discount != null) 'discount': discount,
        if (hsnCode != null) 'hsnCode': hsnCode,
        if (unit != null) 'unit': unit,
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
