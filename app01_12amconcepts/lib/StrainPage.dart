import 'package:flutter/material.dart';
import 'StrainCard.dart';
import 'TopSearch.dart';
import 'ExperienceCard.dart';

class StrainPage extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Strain strain;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  StrainPage(this.strain);

  @override
  Widget build(BuildContext context) {
    Experience experience = new Experience();
    return Material(
          child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //Strain Page Gradients
              end: FractionalOffset.topCenter,
              begin: FractionalOffset.bottomCenter,
              stops: [
                .3,
                1,
              ],
              // colors: [
              //   Color(0xFFDDDDDD),
              //   Color(0xFFEDB78E),//Sativa BACKGROUND orange
              // ], //Sativa Orange BACKGROUND gradient
              colors: [
                Color(0xFFDDDDDD),
                Color(0xFF8BD3A8), //Hybrid BACKGROUND green
              ], //Hybrid Green BACKGROUND gradient
              // colors: [
              //   Color(0xFFDDDDDD),
              //   Color(0xFFCE96CA),//Indica BACKGROUND purple
              // ], //Indica Purple BACKGROUND gradient
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopSearch(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/1466335/pexels-photo-1466335.jpeg"),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 8.0,
                                ),
                              ]),
                        ),
                        Positioned(
                          // padding: const EdgeInsets.all(8.0),
                          bottom:15,
                          right:15,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(50),
                              color: Colors.white60,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(strain.genetics,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(//Strain Title
                  padding: const EdgeInsets.only(bottom: 5, top: 15,),
                  child: Text(strain.name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:28.0, bottom:10,),
                  child: Row( 
                children: <Widget>[
                  Expanded(
                    flex:1,
                    child: Text('THC: ${strain.thc}%',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        )),
                  ),
                 
                  Expanded(
                    flex:1,
                    child: Text(
                      'CBD: ${strain.cbd}%',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  
                  Icon(
                    Icons.star,
                    color: Colors.black54,
                    size: 15,
                  ),
                  Text(': ${strain.rating}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                ],
                  ),
                  
                ),
                 Row(
                children: <Widget>[
                  Expanded(
                  child: Divider(
                color: Colors.black45,
                  ))
                ],
                  ),
                
                  ],
                ),
              ),
              
                 
                Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                children: <Widget>[
                  ExperienceCard(experience),
                  ExperienceCard(experience),
                  ExperienceCard(experience),
                  ExperienceCard(experience),
                ],
              ),
                ),
            ],
          )),
    );
  }
}
