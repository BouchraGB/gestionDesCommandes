//Les imports ndirouhoum hna
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_commandes/addProduct.dart';
import 'afficherTest.dart';
// import 'package:gestion_commandes/dataBase.dart';

//on defini la classe de cette page :
class Home extends StatelessWidget {

  //hna ndefiniw widget w houwa l'interface li ychoufha l user
  @override
  Widget build(BuildContext context){
    return Scaffold(  //Scaffold contient la structure de l'interface de cette page (on definit tous les elements de la page dedans)
    //first : body c la base
      body: Container(
        
        //1--decoration yji fiha styling (kima css)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              HexColor("#a4c3b2"),
              HexColor("#cfdbd5"),
              
            ]
          )
        ),

        child : Container(
          
          child: Column(
            //pour centrer le contenu:
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            
            children: <Widget>[
              Row(
            children: <Widget>[
              Container(
            height: 180,
            width: 180,
                  child: Column(
                  // constraints: BoxConstraints.expand(),
                  children: <Widget>[
                    FlatButton(
                          onPressed: null,
                          // padding: EdgeInsets.all(10),
                          child: Image.asset('images/mesproduits.png')),
                          Text('Mes Produits', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),

                          ])),
                          
            Container(
            height: 180,
            width: 180,
                  child: Column(
                  // constraints: BoxConstraints.expand(),
                  children: <Widget>[
                    FlatButton(
                          onPressed: null,
                          // padding: EdgeInsets.all(10),
                          child: Image.asset('images/mescommandes.png')),
                          Text('Mes commandes', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                    
                          ])),
            ],
            ),

            Row(
            children: <Widget>[
              Container(
            height: 200,
            width: 180,
                  child: Column(
                  // constraints: BoxConstraints.expand(),
                  children: <Widget>[
                    FlatButton(
                          onPressed: null,
                          // padding: EdgeInsets.all(10),
                          child: Image.asset('images/commandespreparees.png')),
                          Text('Commandes', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                          Text('preparees', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                          ])),
            Container(
            height: 200,
            width: 180,
                  child: Column(
                  // constraints: BoxConstraints.expand(),
                  children: <Widget>[
                    FlatButton(
                          onPressed: null,
                          // padding: EdgeInsets.all(10),
                          child: Image.asset('images/commandeslivrees.png')),

                          Text('Commandes', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                          Text('livrees', style: GoogleFonts.robotoSlab(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                          

                          ])),
            ],
            ),

            SizedBox(height: 70,),

            Row(
              children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(left:40),
                child: FloatingActionButton(
                  heroTag: "btn1",
                  
                onPressed: (){Navigator.push( context, MaterialPageRoute(builder: (context) => DBTestPage()),); },
                        
                        child: Icon(Icons.note_add),
            ),
              ),

            Padding(
              padding: const EdgeInsets.only(left:170),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: (){Navigator.push( context, MaterialPageRoute(builder: (context) => AddProduct()),);},
               
                child: Icon(Icons.add),
              ),
            ),

              ],)


            
            ],


            
            ),
        )

    )
    );
  }
}