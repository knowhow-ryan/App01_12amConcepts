import 'package:flutter/material.dart';
import 'StrainCard.dart';
import 'TopSearch.dart';
import 'ExperienceCard.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              end: FractionalOffset.topCenter,
              begin: FractionalOffset.bottomCenter,
              stops: [
                .3,
                .8,
                .9,
              ],
              colors: [
                Color(0xFFDDDDDD), //Light Gray
                // Color(0xFFda8f57), //Orange
                Color(0xFF3e865d), //Green
                // Color(0xFF914d8c), //Purple
                Colors.black87,
              ], //Dark Gray
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
                          bottom: 15,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(50),
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
                    Row(
                      children: <Widget>[
                        Padding(
                          //Strain Title
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            top: 15,
                            right: 8,
                          ),
                          child: Text(strain.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              )),
                        ),
                        Icon(
                          FontAwesomeIcons.pencilAlt,
                          color: Colors.black26,
                          size: 18,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 28.0,
                        bottom: 10,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('THC: ${strain.thc}%',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'CBD: ${strain.cbd}%',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black54,
                            size: 20,
                          ),
                          Text('${strain.rating}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
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
