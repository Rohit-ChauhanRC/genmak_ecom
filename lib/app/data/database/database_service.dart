import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'product_db.dart';
import 'profile_db.dart';
import 'receiving_db.dart';
import 'sell_db.dart';
import 'vendor_db.dart';

class DataBaseService {
  Database? _database;

  Future<Database> get database async {
    //
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'genmakecommerce.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  Future<void> create(Database database, int verion) async {
    await ProductDB().createTable(database);
    await VendorDB().createTable(database);
    await ReceivingDB().createTable(database);
    await SellDB().createTable(database);
    await ProfileDB().createTable(database);
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    ProductDB().onUpgrade(database, oldVersion, newVersion);
    VendorDB().onUpgrade(database, oldVersion, newVersion);
    ReceivingDB().onUpgrade(database, oldVersion, newVersion);
    SellDB().onUpgrade(database, oldVersion, newVersion);
    ProfileDB().onUpgrade(database, oldVersion, newVersion);
  }
}
