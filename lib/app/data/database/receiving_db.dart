import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class ReceivingDB {
  //
  final tableName = 'receiving';

  Future<void> createTable(Database database) async {
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "invoiceId" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "vendorId" TEXT NOT NULL,
    "totalAmount" TEXT NOT NULL,
    "receivingDate" TEXT,
    "productName" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "productQuantity" INTEGER,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
""");
  }

  Future<int> create({
    String? vendorName,
    String? totalAmount,
    String? receivingDate,
    String? productName,
    String? invoiceId,
    String? vendorId,
    String? productId,
    String? productQuantity,
  }) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
        INSERT INTO $tableName (invoiceId,vendorName,vendorId,totalAmount,receivingDate,
        productName,productId,productQuantity) VALUES (?,?,?,?,?,?,?,?)
      ''',
      [
        invoiceId,
        vendorName,
        vendorId,
        totalAmount,
        receivingDate,
        productName,
        productId,
        productQuantity,
      ],
    );
  }

  Future<List<ReceivingModel>> fetchAll() async {
    final database = await DataBaseService().database;
    final receiving = await database.rawQuery('''
        SELECT * from $tableName 
      ''');

    return receiving.map((e) => ReceivingModel.fromMap(e)).toList();
  }

  Future<ReceivingModel> fetchById(int id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE id = ? 
      
      ''', [id]);
    return ReceivingModel.fromMap(product.first);
  }
  // WHERE dates BETWEEN (convert(datetime, '2012-12-12',110) AND (convert(datetime, '2012-12-12',110))

  Future<Iterable<ReceivingModel>> fetchByDate(
      String from, String to, String vendorName) async {
    final database = await DataBaseService().database;
    // Iterable<ReceivingModel> products;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE DATE(receivingDate) >= ? AND DATE(receivingDate) <= ? AND vendorName ==?
      
      ''', [from, to, vendorName]);
    return product.map((e) => ReceivingModel.fromMap(e)).toList();
  }

  Future<Iterable<ReceivingModel>> fetchByDateEqual(
      String from, String vendorName) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE receivingDate == ?  AND vendorName ==?
      
      ''', [from, vendorName]);
    return product.map((e) => ReceivingModel.fromMap(e)).toList();
  }

  Future<Iterable<ReceivingModel>> fetchByInvoiceId(String id) async {
    final database = await DataBaseService().database;
    final product = await database.rawQuery('''
        SELECT * from $tableName WHERE invoiceId = ? 
      
      ''', [id]);
    return product.map((e) => ReceivingModel.fromMap(e));
  }

  Future<int> update({
    required int id,
    String? vendorName,
    String? totalAmount,
    String? receivingDate,
    String? productName,
    String? invoiceId,
    String? vendorId,
    String? productId,
    String? productQuantity,
  }) async {
    final database = await DataBaseService().database;
    return await database.update(
      tableName,
      {
        if (vendorName != null) 'vendorName': vendorName,
        if (totalAmount != null) 'totalAmount': totalAmount,
        if (receivingDate != null) 'receivingDate': receivingDate,
        if (productName != null) 'productName': productName,
        if (invoiceId != null) 'invoiceId': invoiceId,
        if (vendorId != null) 'vendorId': vendorId,
        if (productId != null) 'productId': productId,
        if (productQuantity != null) 'productQuantity': productQuantity,
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

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    // if (oldVersion < newVersion) {
    //   db.execute("ALTER TABLE $tableName ADD COLUMN newCol TEXT;");
    // }
  }
}
