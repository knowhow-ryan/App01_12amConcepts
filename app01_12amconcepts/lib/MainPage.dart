import 'package:flutter/material.dart';
import 'StrainCard.dart';
import 'ExperienceCard.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strain strain = new Strain();
    Experience experience = new Experience();
    return Scaffold(
      body: Container(
        color: Color(0xFFCCCCCC),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              StrainPage(strain),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ExperienceCard(experience),
                    ExperienceCard(experience),
                    ExperienceCard(experience)
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
      
    );
  }
}