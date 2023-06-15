import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
   
  const TestMarkerScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Container(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: EndMarkerPainter(km: 55,description: 'Mercafodsakdlasdkla'),
             ),
         )
      ),
    );
  }
}