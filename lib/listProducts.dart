import 'dart:async';
import 'package:flutter/material.dart';
import 'model/model.dart';
import 'util/database.dart';
import 'package:gestion_commandes/addProduct.dart';
import 'utility.dart';


// Menu item
const menuReset = "Reset Local Data";
List<String> menuOptions = const <String>[menuReset];

class DocList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DocListState();
}

class DocListState extends State<DocList> {

  //declarer une instance de DbHelper pour pouvoir utiliser les fonctions dans cette classe
  DbHelper dbh = DbHelper();

  //declarer une list des produit
  List<Produit> docs;
  int count = 0;
  DateTime cDate;


//cette fonction permet de recuperer la liste des produits
  Future getData() async {

    //tout d'abord initialiser la base de donnees
    final dbFuture = dbh.initializeDb();
    dbFuture.then(
        // result here is the actual reference to the database object.
        (result) {
          //recuperer la liste des produits en utilisant la fonction getProducts() de type future
      final docsFuture = dbh.getProducts();
      docsFuture.then(
          // result here is the list of docs in the database.
          (result) {
        if (result.length >= 0) {
          List<Produit> docList = List<Produit>();
          var count = result.length;
          for (int i = 0; i <= count - 1; i++) {
            docList.add(Produit.fromObjet(result[i]));
          }
          setState(() {
            //si la liste est deja replie il faut la vider
            if (this.docs.length > 0) {
              this.docs.clear();
            }
            //affecter la liste des produits et le compteur
            this.docs = docList;
            this.count = count;
          });
        }
      });
    });
  }


//cette fonction permet d'afficher la liste des produits
  GridView docListItems() {
    return GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(count, (index) {
            return Card(
    clipBehavior: Clip.antiAlias,
    child: Stack(
      
      children: <Widget>[
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children : <Widget>[
            Container(
              width: 130,
              height: 100,
              child: Utility.imageFromBase64String(this.docs[index].image),
            ),

            SizedBox(height : 10),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(this.docs[index].titreProduit),
                SizedBox(height: 8.0),
                Text(this.docs[index].prixProduit.toString()+ " DA"),
              ],
            ),
            ]),
        ),

            Positioned(
              // padding: const EdgeInsets.only(left:0),
              bottom: 125,
              left : 135,
              child:IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showAlertDialog(context,this.docs[index].idProduit);
                // dbh.deleteProduct(this.docs[position].idProduit);
                // getData();
              },
            ),),




      ],
    ),
  );

          }),
          
    );
  }


  showAlertDialog(BuildContext context, int idp) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Annuler"),
    onPressed:  () { Navigator.pop(context);},
  );
  Widget continueButton = FlatButton(
    child: Text("Supprimer"),
    onPressed:  () {
      dbh.deleteProduct(idp);
      getData();
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Voulez vous vraiment supprimer ce produit?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  @override
  Widget build(BuildContext context) {

    //si la liste est vide il faut la remplir en faisant appel a getData()
    if (this.docs == null) {
      this.docs = List<Produit>();
      getData();
    }

    

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Mes produits"), actions: <Widget>[



      ]),
      body: Center(
        child: Scaffold(
          body: Stack(children: <Widget>[
            docListItems(),

            Align(
              // padding: const EdgeInsets.only(left:0),
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: (){Navigator.push( context, MaterialPageRoute(builder: (context) => AddProduct()),);},
               
                child: Icon(Icons.add),
              )
                )
,
            ),


          ]),

        ),
      ),
    );
  }
}
