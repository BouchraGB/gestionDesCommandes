import 'dart:async';
import 'package:gestion_commandes/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        
        child: Stack(
          fit: StackFit.expand,
          
          children: <Widget>[
            Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        './images/logo.png',
                        height: 250,
                        width: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                        children: <Widget>[
                        Text('Votre secretaire pour la gestion ', style: GoogleFonts.modak(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                        Text('des commandes...', style: GoogleFonts.modak(textStyle: TextStyle(color: Colors.black, fontSize: 18))),
                          ]
                        )
                        
                        
                      )
                                            
                          // 
                          

                            
                            
                          
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[

                      Container(
                        height: 70,
                        child : SpinKitWave(color: Colors.blueGrey),
                      )
                        

                      //CircularProgressIndicator(),
                  

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}