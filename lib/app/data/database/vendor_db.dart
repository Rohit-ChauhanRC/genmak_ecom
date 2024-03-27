import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class VendorDB {
  //
  final tableName = 'vendors';

  Future<void> createTable(Database database) async {
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "mobileNo" INTEGER,
    "gst" TEXT,
    "address" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
""");
  }

  Future<int> create({
    required String name,
    int? mobileNo,
    String? gst,
    String? address,
  }) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
        INSERT INTO $tableName (name,mobileNo,gst,address) VALUES (?,?,?,?)
      ''',
      [name, mobileNo, gst, address],
    );
  }

  Future<List<VendorModel>> fetchAll() async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName 
      ''');

    return products.map((e) => VendorModel.fromMap(e)).toList();
  }

  Future<VendorModel> fetchById(int id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE id = ? 
      
      ''', [id]);
    return VendorModel.fromMap(product.first);
  }

  Future<int> update({
    required int id,
    int? mobileNo,
    String? gst,
    String? name,
    String? address,
  }) async {
    final database = await DataBaseService().database;
    return await database.update(
      tableName,
      {
        if (name != null) 'name': name,
        if (mobileNo != null) 'mobileNo': mobileNo,
        if (gst != null) 'gst': gst,
        if (address != null) 'address': address,
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

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    // if (oldVersion < newVersion) {
    //   db.execute("ALTER TABLE $tableName ADD COLUMN newCol TEXT;");
    // }
  }
}
