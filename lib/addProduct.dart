import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'util/util.dart';
import 'package:flutter/services.dart';
import 'model/model.dart';
import 'util/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'utility.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


// Define a custom Form widget.
class AddProduct extends StatefulWidget {
  final DbHelper dbh = DbHelper();
  @override
  AddProductState createState() {
    return AddProductState();
  }
}

//on defini la classe de cette page :
class AddProductState extends State<AddProduct> {


  File _image;
  final picker = ImagePicker();

//declarer les controleurs des inputs : 
  final titreController = TextEditingController();
  final prixController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titreController.dispose();
    prixController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


    Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        String imgString = Utility.base64String(_image.readAsBytesSync());
        Photo photo = Photo(0, imgString);
        Alert(context: context, title: "YES!", desc: "you have choose a photo.",
        content: Utility.imageFromBase64String(photo.nameImage),
        ).show();
        //widget.dbh.save(photo);
        //print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"+_image.path);
      } else {
        print('No image selected.');
      }
    });
  }



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
      child : Form(
        
      key: _formKey,
      child: Column(
                //pour centrer le contenu:
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
                    Column(

        children: <Widget>[
          Text('Ajouter un Produit', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 24))),

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
                  controller: titreController,
                    // The validator receives the text that the user has entered.
                  validator: (value) { return Val.validerTitreProduit(value);},
                  decoration: InputDecoration(
                    labelText: 'Titre du produit'
                  ),
                ),
                TextFormField(
                  controller: prixController,
                  decoration: InputDecoration(
                    labelText: 'Prix du produit'
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                ),


                 FloatingActionButton(
                          onPressed: getImage,
                          tooltip: 'Pick Image',
                          child: Icon(Icons.add_a_photo),
                        ),

                SizedBox(height: 50),



                Text("hnaa", style: TextStyle(fontSize: 20,color: Colors.black)),

                Builder(
                builder: (ctx) =>

                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      String titre=titreController.text;
                      int prix= int.parse(prixController.text);
                      String description = descriptionController.text;
                      String imgString = Utility.base64String(_image.readAsBytesSync());

                      Produit p = Produit(titre,prix,description,imgString);
                      widget.dbh.insertProduct(p);



                      Scaffold.of(ctx)
                          .showSnackBar(SnackBar(content: Text('Ajout de produit en cours')));


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
      )
        ]
     )
    )
      

      )
    );
  }
}