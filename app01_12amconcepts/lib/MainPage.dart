import 'package:flutter/material.dart';
import 'StrainCard.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strain strain = new Strain();
    return Scaffold(
      body: StrainCard(strain),
    );
  }
}