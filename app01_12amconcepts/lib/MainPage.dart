import 'package:flutter/material.dart';
import 'StrainCard.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strain strain = new Strain();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            StrainCard(strain),
            SizedBox(height:12),
            StrainCard(strain),
          ],
        ),
      ),
      
    );
  }
}