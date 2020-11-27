import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'model/model.dart';

class DbHelper {
  
  // Tables
  static String tblProduits = "produits";
  static String tblCommandes = "commandes";


  // Fields of the 'produits' table :
  String idProduit = "idProduit";
  String titreProduit = "titreProduit";
  String prixProduit = "prixProduit";
  String descriptionProduit = "descriptionProduit";


  // Fields of the 'commandes' table :
  String idCommande = "idCommande";
  String numTel = "numTel";
  String nomClient = "nomClient";
  String dateTime = "dateTime";
  String livraison = "livraison";
  String descriptionCommande = "descriptionCommande";



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
        "CREATE TABLE $tblProduits($idProduit INTEGER PRIMARY KEY, $titreProduit TEXT, " +
            "$prixProduit INTEGER, " +
            "$descriptionProduit TEXT, )");
  }

  Future<int> insertProduct(Produit produit) async {
    var r;
    Database db = await this.db;
    try {
      r = await db.insert(tblProduits, produit.toMap());
    } catch (e) {
      debugPrint("insertDoc: " + e.toString());
    }
    return r;
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    var r =
        await db.rawQuery("SELECT * FROM $tblProduits ORDER BY $titreProduit ASC");
    return r;
  }

  Future<List> getProduct(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblProduits WHERE $idProduit = " + id.toString() + "");
    return r;
  }

  // Future<List> getDocFromStr(String payload) async {
  //   List<String> p = payload.split("|");
  //   if (p.length == 2) {
  //     Database db = await this.db;
  //     var r = await db.rawQuery("SELECT * FROM $tblDocs WHERE $docId = " +
  //         p[0] +
  //         " AND $docExpiration = '" +
  //         p[1] +
  //         "'");
  //     return r;
  //   } else
  //     return null;
  // }

  // Future<int> getDocsCount() async {
  //   Database db = await this.db;
  //   var r = Sqflite.firstIntValue(
  //       await db.rawQuery("SELECT COUNT(*) FROM $tblDocs"));
  //   return r;
  // }

  // Future<int> getMaxId() async {
  //   Database db = await this.db;
  //   var r = Sqflite.firstIntValue(
  //       await db.rawQuery("SELECT MAX(id) FROM $tblDocs"));
  //   return r;
  // }

  // Future<int> updateDoc(Doc doc) async {
  //   var db = await this.db;
  //   var r = await db
  //       .update(tblDocs, doc.toMap(), where: "$docId = ?", whereArgs: [doc.id]);
  //   return r;
  // }

  Future<int> deleteProduct(int id) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tblProduits WHERE $idProduit = $id");
    return r;
  }

  // Future<int> deleteRows(String tbl) async {
  //   var db = await this.db;
  //   int r = await db.rawDelete("DELETE FROM $tbl");
  //   return r;
  // }
}
