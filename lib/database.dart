import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'model/model.dart';

class DbHelper {
  // Tables
  static String tblProduit = "produit";
  static String tblCommande = "commande";
  static String tblProduitCommande = "produitcommande";

  // Fields of the 'produit' table :
  String idProduit = "idProduit";
  String titreProduit = "titreProduit";
  String prixProduit = "prixProduit";
  String descriptionProduit = "descriptionProduit";

  // Fields of the 'commande' table :
  String idCommande = "idCommande";
  String numTel = "numTel";
  String nomClient = "nomClient";
  String dateTime = "dateTime";
  String livraison = "livraison";
  String descriptionCommande = "descriptionCommande";

  // Fields of the 'produitcommande' table :
  String idProduitCommande = "idProduitCommande";
  String titreProduitCommande = "titreProduitCommande";
  String quantite = "quantite";
  String idCommandep = "idCommandep";
  String idProduitp = "idProduitp";

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory d = await getApplicationDocumentsDirectory();
    String p = d.path + "/gestionCommandes.db";
    var db = await openDatabase(p, version: 1, onCreate: _createDb);
    return db;
  }

  // Create database table
  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblProduit($idProduit INTEGER PRIMARY KEY, $titreProduit TEXT, " +
            "$prixProduit INTEGER, " +
            "$descriptionProduit TEXT, )");
    await db.execute(
        "CREATE TABLE $tblCommande($idCommande INTEGER PRIMARY KEY, $numTel INTEGER, " +
            "$nomClient TEXT, " +
            "$dateTime TEXT, " +
            "$livraison INTEGER, " +
            "$descriptionCommande TEXT, )");
    await db.execute(
        "CREATE TABLE $tblProduitCommande($idProduitCommande INTEGER PRIMARY KEY, $titreProduitCommande TEXT, " +
            "$quantite INTEGER, " +
            "$idCommandep INTEGER, " +
            "$idProduitp INTEGER, )");
  }
/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////// Region Produit //////////////////////
/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////

  Future<int> insertProduct(Produit produit) async {
    var r;
    Database db = await this.db;
    try {
      r = await db.insert(tblProduit, produit.toMap());
    } catch (e) {
      debugPrint("insertProduct: " + e.toString());
    }
    return r;
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    var r = await db
        .rawQuery("SELECT * FROM $tblProduit ORDER BY $titreProduit ASC");
    return r;
  }

  Future<List> getProduct(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblProduit WHERE $idProduit = " + id.toString() + "");
    return r;
  }

  Future<int> getProductsCount() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblProduit"));
    return r;
  }

  Future<int> getMaxIdProduit() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT MAX(idProduit) FROM $tblProduit"));
    return r;
  }

  Future<int> updateProduct(Produit produit) async {
    var db = await this.db;
    var r = await db.update(tblProduit, produit.toMap(),
        where: "$idProduit = ?", whereArgs: [produit.idProduit]);
    return r;
  }

  Future<int> deleteProduct(int id) async {
    var db = await this.db;
    int r =
        await db.rawDelete("DELETE FROM $tblProduit WHERE $idProduit = $id");
    return r;
  }

/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////// Region Commande //////////////////////
/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////

  Future<int> insertCommande(Commande commande) async {
    var r;
    Database db = await this.db;
    try {
      r = await db.insert(tblCommande, commande.toMap());
    } catch (e) {
      debugPrint("insertCommande: " + e.toString());
    }
    return r;
  }

  Future<List> getCommandes() async {
    Database db = await this.db;
    var r =
        await db.rawQuery("SELECT * FROM $tblCommande ORDER BY $nomClient ASC");
    return r;
  }

  Future<List> getCommande(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblCommande WHERE $idCommande = " + id.toString() + "");
    return r;
  }

  Future<int> getCommandesCount() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblCommande"));
    return r;
  }

  Future<int> getMaxIdCommande() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT MAX(idCommande) FROM $tblCommande"));
    return r;
  }

  Future<int> updateCommande(Commande commande) async {
    var db = await this.db;
    var r = await db.update(tblCommande, commande.toMap(),
        where: "$idCommande = ?", whereArgs: [commande.idCommande]);
    return r;
  }

  Future<int> deleteCommande(int id) async {
    var db = await this.db;
    int r =
        await db.rawDelete("DELETE FROM $tblCommande WHERE $idCommande = $id");
    return r;
  }
  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
////////////// Region ProduitCommande //////////////////
/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////

  Future<int> insertProduitCommande(ProduitCommande produitCommande) async {
    var r;
    Database db = await this.db;
    try {
      r = await db.insert(tblProduitCommande, produitCommande.toMap());
    } catch (e) {
      debugPrint("insertProduitCommande: " + e.toString());
    }
    return r;
  }

  Future<List> getProduitCommandes() async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblProduitCommande ORDER BY $titreProduitCommande ASC");
    return r;
  }

  Future<List> getProduitCommande(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblProduitCommande WHERE $idProduitCommande = " +
            id.toString() +
            "");
    return r;
  }

  Future<int> getProduitCommandesCount() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblProduitCommande"));
    return r;
  }

  Future<int> getMaxIdProduitCommande() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(await db
        .rawQuery("SELECT MAX(idProduitCommande) FROM $tblProduitCommande"));
    return r;
  }

  Future<int> updateProduitCommande(ProduitCommande produitCommande) async {
    var db = await this.db;
    var r = await db.update(tblProduitCommande, produitCommande.toMap(),
        where: "$idProduitCommande = ?",
        whereArgs: [produitCommande.idProduitCommande]);
    return r;
  }

  Future<int> deleteProduitCommande(int id) async {
    var db = await this.db;
    int r = await db.rawDelete(
        "DELETE FROM $tblProduitCommande WHERE $idProduitCommande = $id");
    return r;
  }

  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////// Delete table //////////////////////
/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////

  Future<int> deleteRows(String tbl) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tbl");
    return r;
  }
}
