import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database.dart';


//on defini la classe de cette page :
class AddProduct extends StatelessWidget {





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
      child : Column(
        //pour centrer le contenu:
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Ajouter un Produit', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 24))),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ID du produit'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Titre du produit'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prix du produit'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                ),

                SizedBox(height: 50),



                Text("hnaa", style: TextStyle(fontSize: 20,color: Colors.black)),

              RaisedButton(
                onPressed: () {print('Console Message Using Debug Print');  },
                textColor: Colors.white,
                
                
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                      children: <Widget>[
                          Text('Enregistrer', style: TextStyle(fontSize: 20)),
                          Icon(Icons.save),
                      ]
                    ),
                  )
                  
                  )),

              ],
            ),
          )
        ] 
      )
      )
    );
  }
}