import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:e_cart/models/cart_model.dart';
import 'dart:io' as io;

class DBHelper{
  static Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db!;
    }

    _db= await initDatabase();
    return _db;
  }

  initDatabase() async{
    io.Directory documentDirectory= await getApplicationDocumentsDirectory();
    String path= join(documentDirectory.path, 'cart.db');
    var db= await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate (Database db , int version )async{
    await db.execute(
            'CREATE TABLE cart ('
                'id TEXT PRIMARY KEY , '
                'productId VARCHAR UNIQUE,'
                'productName TEXT,'
                'initialPrice TEXT, '
                'productPrice TEXT , '
                'quantity TEXT, '
                'unitTag TEXT, '
                'image TEXT, '
                'productType TEXT)'
    );
  }

  Future<Cart> insert(Cart cart) async{
    var dbClient= await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async{
    var dbClient= await db;
    final List<Map<String, Object?>> queryResult= await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deleteFromCart(String id) async{
    var dbClient= await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateQuantity(Cart cart) async{
    var dbClient= await db;
    return await dbClient!.update(
        'cart',
        cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id]
    );
  }
}