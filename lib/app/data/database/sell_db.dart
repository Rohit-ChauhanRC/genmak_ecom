import 'package:genmak_ecom/app/data/models/sell_model.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class SellDB {
  //
  final tableName = 'sell';

  Future<void> createTable(Database database) async {
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "invoiceId" TEXT NOT NULL,
    "productName" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "productWeight" TEXT ,
    "price" TEXT NOT NULL,
    "gst" TEXT NOT NULL,
    "count" INTEGER,
    "productQuantity" TEXT,
    "receivingDate" TEXT,
    "unit" unit,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
""");
  }

  Future<int> create({
    required String productName,
    required String productWeight,
    required String price,
    String? productQuantity,
    String? receivingDate,
    String? productId,
    String? invoiceId,
    String? gst,
    String? unit,
    int? count,
  }) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
        INSERT INTO $tableName (productName,productId,productWeight,price,productQuantity, receivingDate,invoiceId,gst,count,unit) VALUES (?,?,?,?,?,?,?,?,?,?)
      ''',
      [
        productName,
        productId,
        productWeight,
        price,
        productQuantity,
        receivingDate,
        invoiceId,
        gst,
        count,
        unit
      ],
    );
  }

  Future<List<SellModel>> fetchAll() async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName 
      ''');

    return products.map((e) => SellModel.fromMap(e)).toList();
  }

  Future<SellModel> fetchById(int id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE id = ? 
      
      ''', [id]);
    return SellModel.fromMap(product.first);
  }

  Future<Iterable<SellModel>> fetchByInvoiceId(String id) async {
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName WHERE invoiceId = ? 
      
      ''', [id]);
    return products.map((e) => SellModel.fromMap(e)).toList();
  }

  Future<Iterable<SellModel>> fetchByDate(String from, String to) async {
    // WHERE dates BETWEEN (convert(datetime, '2012-12-12',110) AND (convert(datetime, '2012-12-12',110))

    // print(from,to);
    final database = await DataBaseService().database;
    final products = await database.rawQuery('''
        SELECT * from $tableName WHERE DATE(receivingDate) >=? AND DATE(receivingDate) <=?
      
      ''', [from, to]);
    print(products.toSet());
    return products.map((e) => SellModel.fromMap(e)).toList();
  }

  Future<Iterable<SellModel>> fetchByDateEqual(
    String from,
  ) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE receivingDate == ?  
      
      ''', [from]);
    return product.map((e) => SellModel.fromMap(e)).toList();
  }

  Future<int> update({
    required int id,
    String? productName,
    String? productId,
    String? productWeight,
    String? price,
    String? productQuantity,
    DateTime? receivingDate,
    String? invoiceId,
  }) async {
    final database = await DataBaseService().database;
    return await database.update(
      tableName,
      {
        if (productName != null) 'productName': productName,
        if (productId != null) 'productId': productId,
        if (price != null) 'price': price,
        if (productWeight != null) 'productWeight': productWeight,
        if (productQuantity != null) 'productQuantity': productQuantity,
        if (receivingDate != null) 'receivingDate': receivingDate,
        if (invoiceId != null) 'invoiceId': invoiceId,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final database = await DataBaseService().database;

    await database.rawDelete('''
  DELETE FROM $tableName WHERE id = ?
''', [id]);
  }

  Future<void> alterTble() async {
    final database = await DataBaseService().database;

    await database.execute(
      '''
  ALTER TABLE $tableName ALTER COLUMN receivingDate DATETIME
''',
    );
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    // if (oldVersion < newVersion) {
    //   db.execute("ALTER TABLE $tableName ADD COLUMN newCol TEXT;");
    // }
  }
}
