import 'dart:async';
import 'package:flutter/material.dart';
import 'model/model.dart';
import 'util/database.dart';
// import 'package:gestion_commandes/addProduct.dart';
import 'package:gestion_commandes/addCommande.dart';



// Menu item
const menuReset = "Reset Local Data";
List<String> menuOptions = const <String>[menuReset];

class ProduitsCommandeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProduitsCommandeListState();
}

class ProduitsCommandeListState extends State<ProduitsCommandeList> {

  //declarer une instance de DbHelper pour pouvoir utiliser les fonctions dans cette classe
  DbHelper dbh = DbHelper();

  //declarer une list des produit
  List<ProduitCommande> docs;
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
      final docsFuture = dbh.getProduitCommandes();
      docsFuture.then(
          // result here is the list of docs in the database.
          (result) {
        if (result.length >= 0) {
          List<ProduitCommande> docList = List<ProduitCommande>();
          var count = result.length;
          for (int i = 0; i <= count - 1; i++) {
            docList.add(ProduitCommande.fromObjet(result[i]));
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
  ListView docListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 1.0,
          child: ListTile(
            leading: CircleAvatar(
              // backgroundColor:
              //     (Val.GetExpiryStr(this.docs[position].expiration) != "0")
              //         ? Colors.blue
              //         : Colors.red,
              child: Text(
                this.docs[position].idCommandep.toString(),
              ),
            ),
            title: Text(this.docs[position].idCommandep.toString()+ " "+ this.docs[position].idProduitp.toString()+ " : "+this.docs[position].description),
            // subtitle: Text(Val.GetExpiryStr(this.docs[position].expiration) +
            //     dl +
            //     "\nExp: " +
            //     DateUtils.convertToDateFull(this.docs[position].expiration)),
            onTap: () {

              //navigateToDetail(this.docs[position]);
            },
            trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        showAlertDialog(context,this.docs[position].idCommandep,this.docs[position].idProduitp);
                        // dbh.deleteProduct(this.docs[position].idProduit);
                        // getData();
                      },
                    ),
          ),
          
        );
      },
    );
  }


  showAlertDialog(BuildContext context, int idc, int idp) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Annuler"),
    onPressed:  () { Navigator.pop(context);},
  );
  Widget continueButton = FlatButton(
    child: Text("Supprimer"),
    onPressed:  () {
      dbh.deleteProduitCommande(idc,idp);
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
      this.docs = List<ProduitCommande>();
      getData();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Produits commandes"), actions: <Widget>[
        // PopupMenuButton(
        //   onSelected: null,//_selectMenu,
        //   itemBuilder: (BuildContext context) {
        //     return menuOptions.map((String choice) {
        //       return PopupMenuItem<String>(
        //         value: choice,
        //         child: Text(choice),
        //       );
        //     }).toList();
        //   },
        // ),
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
                onPressed: (){Navigator.push( context, MaterialPageRoute(builder: (context) => AddCommande()),);},
               
                child: Icon(Icons.add),
              )
                )
,
            ),


          ]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: "Add new doc",
          //   child: Icon(Icons.add),
          // ),
        ),
      ),
    );
  }
}
