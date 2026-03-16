import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDb {
  static final ProductDb instance = ProductDb._init();
  static Database? _database;

  ProductDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE cart (
  id $idType,
  product_id $integerType,
  product_title $textType,
  product_image $textType,
  category $textType,
  price $realType,
  quantity $integerType,
  subtotal $realType,
  created_at $textType
)
''');
  }

  Future<int> addToCart(Map<String, dynamic> item) async {
    final db = await instance.database;

    final existingItem = await getCartItemByProductId(item['product_id']);
    if (existingItem != null) {
      int newQuantity = existingItem['quantity'] + item['quantity'];
      double newSubtotal = newQuantity * (existingItem['price'] as double);

      return await db.update(
        'cart',
        {
          'quantity': newQuantity,
          'subtotal': newSubtotal,
          'created_at': DateTime.now().toIso8601String(),
        },
        where: 'product_id = ?',
        whereArgs: [item['product_id']],
      );
    } else {
      return await db.insert('cart', item);
    }
  }

  Future<Map<String, dynamic>?> getCartItemByProductId(int productId) async {
    final db = await instance.database;
    final results = await db.query(
      'cart',
      where: 'product_id = ?',
      whereArgs: [productId],
      limit: 1,
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cart', orderBy: 'created_at DESC');
  }

  Future<int> updateCartItem(Map<String, dynamic> item) async {
    final db = await instance.database;
    return await db.update(
      'cart',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  Future<int> deleteCartItem(int id) async {
    final db = await instance.database;
    return await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
