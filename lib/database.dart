import 'dart:async'; 
import 'dart:io'; 
import 'package:path/path.dart'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:sqflite/sqflite.dart'; 
import 'produit.dart';

class SQLiteDbProvider { 
   SQLiteDbProvider._(); 
   static final SQLiteDbProvider db = SQLiteDbProvider._(); 
   static Database _database; 

   Future<Database> get database async { 
   if (_database != null) 
   return _database; 
   _database = await initDB(); 
   return _database; 
}
initDB() async { 
   Directory documentsDirectory = await getApplicationDocumentsDirectory(); 
   String path = join(documentsDirectory.path, "CommandesDB.db"); 
   return await openDatabase(
      path, 
      version: 1,
      onOpen: (db) {}, 
      onCreate: (Database db, int version) async {
         await db.execute(
            "CREATE TABLE produitsss (id INTEGER PRIMARY KEY, titre TEXT, prix INTEGER)"
         ); 
         await db.execute(
            "INSERT INTO produits ('id', 'name', 'prix') values (?, ?, ?)", 
            [1, "chapeau simple", 600]
         ); 
         await db.execute(
            "INSERT INTO produits ('id', 'name', 'prix') values (?, ?, ?)", 
            [2, "chapeau personnalise", 700]
         );
      }
   ); 
}

void getAllProducts() async { 
   final db = await database; 
   List<Map> 
   results = await db.query("produits", columns: Produit.columns, orderBy: "id ASC"); 
   
   List<Produit> products = new List(); 
   results.forEach((result) { 
     
      Produit product = Produit.fromMap(result); 
      print("hhh"+product.titre);
      print("hhh"+product.prix.toString());
      products.add(product); 
   }); 
  //  return products; 
}


Future<Produit> getProductById(int id) async {
   final db = await database; 
   var result = await db.query("produits", where: "id = ", whereArgs: [id]); 
   return result.isNotEmpty ? Produit.fromMap(result.first) : Null; 
}

insert(Produit product) async { 
   final db = await database; 
   var maxIdResult = await db.rawQuery(
      "SELECT MAX(id)+1 as last_inserted_id FROM produits");

   var id = maxIdResult.first["last_inserted_id"]; 
   var result = await db.rawInsert(
      "INSERT Into produits (id, titre,prix)" 
      " VALUES (?, ?, ?)", 
      [id, product.titre, product.prix] 
   ); 
   return result; 
}
update(Produit product) async { 
   final db = await database; 
   var result = await db.update("produits", product.toMap(), 
   where: "id = ?", whereArgs: [product.id]); return result; 
} 
delete(int id) async { 
   final db = await database; 
   db.delete("produits", where: "id = ?", whereArgs: [id]); 
}

}