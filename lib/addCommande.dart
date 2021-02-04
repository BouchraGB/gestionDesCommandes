import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'util/util.dart';
import 'package:flutter/services.dart';

import 'util/database.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'model/model.dart';



// Define a custom Form widget.
class AddCommande extends StatefulWidget{


//  final DbHelper dbh = DbHelper();
  @override
  AddCommandeState createState() {
    return AddCommandeState();
  }
}

//on defini la classe de cette page :
class AddCommandeState extends State<AddCommande> {


  //les controlleurs:
  final descProController = TextEditingController();
  final numTelController = TextEditingController();
  final usernameController = TextEditingController();
  final lieuController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool valuefirst = false; 
  final noteController = TextEditingController();

  String dropdownValue = '1';
  int dropdownValueID ;

  //declarer une instance de DbHelper pour pouvoir utiliser les fonctions dans cette classe
  DbHelper dbh = DbHelper();

  //declarer une list des produit
  List<Produit> docs;
  int count = 0;
  DateTime cDate;


  int idCommande = 0;

  Future recupId() async {
    final dbFuture = dbh.initializeDb();

        dbFuture.then(
        // result here is the actual reference to the database object.
        (result) {
          //recuperer la liste des produits en utilisant la fonction getProducts() de type future
      final idCom = dbh.getMaxIdCommande();
      idCom.then(
          // result here is the list of docs in the database.
          (result) {
            idCommande = result;
          });
    });


  }

//une liste des produits commandes
  List<List<String>> prodCom = [];


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

  testerList(){
 
    return DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.deepPurple
    ),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
        // dropdownValueID = 
      });
    },
    items: docs//['One', 'Two', 'Free', 'Four']
      .map<DropdownMenuItem<String>>((Produit value) {
        return DropdownMenuItem<String>(
          value: value.idProduit.toString(),
          child: Text(value.titreProduit),
        );
      })
      .toList(),
  );
  }

    double _height;
  double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

   

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);



  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
      recupId();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  // String _date = "Not set";
  // String _time = "Not set";





  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String titreProduit;
  int prixProduit;
  String descriptionProduit;

  //hna ndefiniw widget w houwa l'interface li ychoufha l user
  @override
  Widget build(BuildContext context){
     dateTime = DateFormat.yMd().format(DateTime.now());

         //si la liste est vide il faut la remplir en faisant appel a getData()
    if (this.docs == null) {
      this.docs = List<Produit>();
      getData();
    }


    return Scaffold( 
      body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              HexColor("#a4c3b2"),
              HexColor("#cfdbd5"),
              
            ]
          )
        ),
      child : SingleChildScrollView(
      child : Form(
        
      key: _formKey,
      child: Column(
                //pour centrer le contenu:
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
                    Column(

        children: <Widget>[
          Text('Ajouter une Commande', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 24))),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'ID du produit'
                //   ),
                // ),
                TextFormField(
                  controller: usernameController,
                  //   // The validator receives the text that the user has entered.
                  // validator: (value) { return Val.validerTitreProduit(value);},
                  decoration: InputDecoration(
                    labelText: 'Nom du client'
                  ),
                ),
                TextFormField(
                  controller: numTelController,
                  decoration: InputDecoration(
                    labelText: 'Num Tel'
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],                ),




                Text(
                  'Choose Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String val) {
                        _setDate = val;
                      },
                      // decoration: InputDecoration(
                      //     disabledBorder:
                      //         UnderlineInputBorder(borderSide: BorderSide.none),
                      //     // labelText: 'Time',
                      //     contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),



                Text(
                  'Choose Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: 30),

                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),


                Row(
                  children : <Widget>[
                                    Text(
                  'Livraison',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),

                                  Checkbox(  
                      checkColor: Colors.greenAccent,  
                      activeColor: Colors.red,  
                      value: this.valuefirst,  
                      onChanged: (bool value) {  
                        setState(() {  
                          this.valuefirst = value;  
                        });  
                      },  
                    ),

                  ]
                ),




                TextFormField(
                  controller: lieuController,
                  //   // The validator receives the text that the user has entered.
                  // validator: (value) { return Val.validerTitreProduit(value);},
                  decoration: InputDecoration(
                    labelText: 'Lieu'
                  ),
                ),

 


Row(children: <Widget>[
  testerList(),
SizedBox(
  width: 120,
  child:     TextFormField(
  controller: descProController,
  //   // The validator receives the text that the user has entered.
  // validator: (value) { return Val.validerTitreProduit(value);},
  decoration: InputDecoration(
    labelText: 'Description',
  ),
  ),
),
  ElevatedButton(
    onPressed: () {
      List<String> use = [];
      // prodCom.clear();
      use.add(dropdownValue.toString());
      use.add(descProController.text);
      prodCom.add(use);
    },
    child: Text('Add')
  ),

],),



                 TextFormField(
                  controller: noteController,
                  //   // The validator receives the text that the user has entered.
                  // validator: (value) { return Val.validerTitreProduit(value);},
                  decoration: InputDecoration(
                    labelText: 'note'
                  ),
                ),






                SizedBox(height: 30,),





                Text("hnaa"+idCommande.toString(), style: TextStyle(fontSize: 20,color: Colors.black)),

                Builder(
                builder: (ctx) =>

                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      
        
                        String username = usernameController.text;
                        int numTel = int.parse(numTelController.text);
                        String date = _dateController.text;
                        String time = _timeController.text;
                        int livraison;
                        if(valuefirst == true){livraison=1;}
                        else{livraison = 0;}

                        String lieu = lieuController.text;
                        String descCommande = noteController.text;
                        int etat = 0;

                        Commande c = Commande(numTel,username,date,time,livraison,lieu,etat,descCommande);

                        dbh.insertCommande(c);
                        
                        if(idCommande == null){idCommande=0;}
                        

                        for (List<String> e in this.prodCom){
                            int idP = int.parse(e[0]);
                            String descP = e[1];

                            ProduitCommande pc = ProduitCommande(idCommande+1,idP,descP);
 
                            dbh.insertProduitCommande(pc);
                        }

                        
                      
                      
                     



                      Scaffold.of(ctx)
                          .showSnackBar(SnackBar(content: Text('Ajout de commande en cours')));


                    }
                  },
                  child: Text('Submit'),
                )),

              // RaisedButton(
              //   onPressed: () {print('Console Message Using Debug Print');  },
              //   textColor: Colors.white,
                
                
              //   padding: const EdgeInsets.all(0.0),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: <Color>[
              //           Color(0xFF0D47A1),
              //           Color(0xFF1976D2),
              //           Color(0xFF42A5F5),
              //         ],
              //       ),
              //     ),
              //     padding: const EdgeInsets.all(10.0),
              //     child: SizedBox(
              //       width: 140,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              //         crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
              //         children: <Widget>[
              //             Text('Enregistrer', style: TextStyle(fontSize: 20)),
              //             Icon(Icons.save),
              //         ]
              //       ),
              //     )
                  
              //     )),

              

              ],
            ),
          )
        ] 
      ),



      
        ]
     )
    ))
      

      )
    );
  }
}