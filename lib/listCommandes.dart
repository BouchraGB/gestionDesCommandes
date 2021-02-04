import 'dart:async';
import 'package:flutter/material.dart';
import 'model/model.dart';
import 'util/database.dart';
// import 'package:gestion_commandes/addProduct.dart';
import 'package:gestion_commandes/addCommande.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


// Menu item
const menuReset = "Reset Local Data";
List<String> menuOptions = const <String>[menuReset];

class CommandesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommandesListState();
}

class CommandesListState extends State<CommandesList> {

  //declarer une instance de DbHelper pour pouvoir utiliser les fonctions dans cette classe
  DbHelper dbh = DbHelper();

  //declarer une list des produit
  List<Commande> docs;
  int count = 0;
  DateTime cDate;


Widget _simplePopup(int id,int ex) => PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Details"),
                  
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Changer etat"),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Supprimer"),
                ),
              ],

            onSelected: (result) {
              if (result == 2) {
                return showDialog(
                context: context,
                builder: (context) {
                  return MyDialog(
                      id: id , 
                      ex: ex,);
                });
                 
                }
              },
        );



//cette fonction permet de recuperer la liste des produits
  Future getData() async {

    //tout d'abord initialiser la base de donnees
    final dbFuture = dbh.initializeDb();
    dbFuture.then(
        // result here is the actual reference to the database object.
        (result) {
          //recuperer la liste des produits en utilisant la fonction getProducts() de type future
      final docsFuture = dbh.getCommandes();
      docsFuture.then(
          // result here is the list of docs in the database.
          (result) {
        if (result.length >= 0) {
          List<Commande> docList = List<Commande>();
          var count = result.length;
          for (int i = 0; i <= count - 1; i++) {
            docList.add(Commande.fromObjet(result[i]));
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
        return DataTable(
          columns: [
            DataColumn(
              label: Text('Date'),
            ),
            DataColumn(
              label: Text('Heure'),
            ),
            DataColumn(
              label: Text('Etat'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text(' '),
            )
          ],
          rows: docs
              .map(
                (commande) => DataRow(cells: [
                  DataCell(
                    Text(commande.dateTime),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {

                    },
                  ),
                  DataCell(
                    Text(
                      commande.heure,
                    ),
                    onTap: () {

                    },
                  ),
                  DataCell(
                    Text(
                      commande.etat.toString(),
                    ),
                    onTap: () {

                    },
                  ),
                  DataCell(
                  _simplePopup(this.docs[position].idCommande,this.docs[position].etat),
                  ),
                  
                ]),
              )
              .toList(),
        );
      })
        ;

        // return Card(
        //   color: Colors.white,
        //   elevation: 1.0,
        //   child: Row(
        //     children: <Widget>[SizedBox(
        //       width: 300,
        //       child: ListTile(
        //         leading: CircleAvatar(

        //           child: Text(
        //             this.docs[position].idCommande.toString(),
        //           ),
        //         ),
        //         title: Text(this.docs[position].nomClient+ " "+ this.docs[position].etat.toString()),

        //         onTap: () {

        //           //navigateToDetail(this.docs[position]);
        //         },
        //         trailing: IconButton(
        //                   icon: Icon(Icons.delete_forever),
        //                   onPressed: () {
        //                     showAlertDialog(context,this.docs[position].idCommande);
        //                     // dbh.deleteProduct(this.docs[position].idProduit);
        //                     // getData();
        //                   },
        //                 ),
        //       ),
        //     ),
        //       _simplePopup(this.docs[position].idCommande,this.docs[position].etat),
        //     ]
        //   ),
          
        // );
    //   },
    // );
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
      dbh.deleteCommande(idp);
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
      this.docs = List<Commande>();
      getData();
    }

    List<String> dropDown = <String>["Tous", "Preparees", "Livrees", "Annulees"];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Mes commandes"), actions: <Widget>[

        new DropdownButton<String>(
          underline: Container(),
          icon: Icon(Icons.sort,color: Colors.white),
          items: dropDown.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String value) {
            setState(() {});
          })

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
        ),
      ),
    );
  }
}




class MyDialog extends StatefulWidget {
    MyDialog({
    this.id,
    this.ex,
  });

  final int id;
  final int ex;

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {

DbHelper dbh = DbHelper();

 bool valOne=false,valTwo=false,valThree=false,valFour=false;
    @override
  void initState() {
    super.initState();
      if (widget.ex == 0) {valOne = true;}
        else{
        if (widget.ex == 1) {valTwo = true;}
        if (widget.ex == 2) {valThree = true;}
        if (widget.ex == 3) {valFour = true;}
        }
  }

int _radioValue1 = 2;
 



    @override
  Widget build(BuildContext context) {
    return AlertDialog(//context: context, 
      title: Text('Changer etat de la commande'), 
      //desc: Text("Flutter is awesome."),
      content: Column(
      // child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Row(children: [
            Column(
              children: [
                  Checkbox(  
                      checkColor: Colors.greenAccent,  
                      activeColor: Colors.red,  
                      value: this.valOne,  
                      onChanged: (bool valueB) {  
                        setState(() {  
                          this.valOne = valueB;  
                          valFour = false;
                          valTwo = false;
                          valThree = false;
                        }); 

                      },  
                    ),
                Text("pas prete",style: TextStyle(fontSize: 14)),
                // Text("preparee",style: TextStyle(fontSize: 14)),
              ],
            ),

            Column(
              children: [
                Checkbox(  
                  // checkColor: Colors.greenAccent,  
                  // activeColor: Colors.red,  
                  value: valTwo,//this.valuefirst,  
                  onChanged: (bool value) {  
                    setState(() {  
                      valTwo = value; 
                      valOne = false;
                      valFour = false;
                      valThree = false; 
                    }); 

                  },  
                ),
                Text("preparee",style: TextStyle(fontSize: 14)),
              ],
            ),

            Column(
              children: [
                Checkbox(  
                  // checkColor: Colors.greenAccent,  
                  // activeColor: Colors.red,  
                  value: valThree,//this.valuefirst,  
                  onChanged: (bool value) {  
                    setState(() {  
                      valThree = value;  
                      valOne = false;
                      valTwo = false;
                      valFour = false;
                    });  

                  },  
                ),
                Text("livree",style: TextStyle(fontSize: 14)),
              ],
            ),

                        Column(
              children: [
                Checkbox(  
                  checkColor: Colors.greenAccent,  
                  activeColor: Colors.red,  
                  value: valFour,//this.valuefirst,  
                  onChanged: (bool value) {  
                    setState(() {  
                      valFour = value;  
                      valOne = false;
                      valTwo = false;
                      valThree = false;
                    });  

                  },  
                ),
                Text("Annulee",style: TextStyle(fontSize: 14)),
              ],
            ),


            ],),

          ]
      ),
        actions: <Widget>[
          TextButton(
            child: Text('Approve'),
            onPressed: () {
              int i=0;
              int etat;
              if(valOne == true) {i++; etat = 0;}
              if(valTwo == true) {i++;etat = 1;}
              if(valThree == true) {i++; etat = 2;}
              if(valFour == true) {i++; etat = 3;}

              if(i>1)
              Alert(context: context, title: "ERROR", desc: "you should choose only one.",type: AlertType.warning,).show();
              else {
                dbh.updateEtatCommande(widget.id,etat);
                Alert(context: context, title: "Done", desc: "l'etat de la commande a ete change.",
                
                    buttons: [
                        DialogButton(
                          child: Text(
                            "OK!",
                            //style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          width: 120,
                        )
                      ],
              ).show();
              }
              //Navigator.of(context).pop();
            },
          ),
        ],
      );

  }

  

}