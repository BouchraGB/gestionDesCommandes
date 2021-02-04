import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';


class PieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {


    @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              HexColor("#a4c3b2"),
              HexColor("#cfdbd5"),
              
            ]
          )
        ),
      // child: ,
    );
  }
}