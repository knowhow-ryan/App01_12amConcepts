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
        
         decoration: BoxDecoration(
        gradient: LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        stops: [.6, .9,],
                        // colors: [
                        //   Color(0xFFCCCCCC),
                        //   Color(0xFFEDB78E),
                        // ], //Sativa Orange BACKGROUND gradient
                        colors: [
                          Color(0xFFCCCCCC),
                          Color(0xFF8BD3A8),
                        ], //Hybrid Green BACKGROUND gradient
                        // colors: [
                        //   Color(0xFFCCCCCC),
                        //   Color(0xFFCE96CA),
                        // ], //Indica Purple BACKGROUND gradient

                      ), 
      ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              // Expanded( //StrainCard Page Presentation
              //   child:
              // ListView(
              //   children: <Widget>[
              //     StrainCard(strain),
              
              //   ],
              // ),
              // ),
              StrainPage(strain), //Strain Page Presentation
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ExperienceCard(experience),
                    ExperienceCard(experience),
                    ExperienceCard(experience)
                  
                  ],
                ),
              ),
            ]
            
          ),
        
      )
    ));
  }
}