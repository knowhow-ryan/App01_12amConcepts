import 'package:flutter/material.dart';
import 'TopSearch.dart';
import 'Experience.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';

class StrainPage extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Strain strain;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  StrainPage(this.strain);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
              //Starting Gradient with Smoke Background
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: FractionalOffset.topCenter,
                  begin: FractionalOffset.bottomCenter,
                  stops: [
                    .05,
                    .45,
                  ],
                  colors: [
                    Color(0xFF55B57D),
                    Color(0xFF000000)
                  ],
                ),
              ),
              child: Image.network(
                "http://justcole.design/wp-content/uploads/2020/02/Smokey-Background-Side.png", //TODO: update this to an assett image
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                colorBlendMode: BlendMode.overlay,
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopSearch(),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 5),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
                    
              //       Row(
              //         children: <Widget>[
              //           Padding(
              //             //Strain Title
              //             padding: const EdgeInsets.only(
              //               bottom: 5,
              //               top: 15,
              //               right: 8,
              //             ),
              //             child: Text(strain.name.phraseString,
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 38,
              //                 )),
              //           ),
              //           Icon(
              //             FontAwesomeIcons.pencilAlt,
              //             color: Colors.white70,
              //             size: 18,
              //           ),
              //         ],
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(
              //           right: 8.0,
              //           bottom: 10,
              //         ),
              //         child: Row(
              //           children: <Widget>[
              //             Text('THC: ${strain.thcPercent}%',
              //                 style: TextStyle(
              //                   color: Colors.white70,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 25,
              //                 )),
              //             Padding(
              //               padding: const EdgeInsets.only(left:15.0, right:15,),
              //               child: Text(
              //                 'CBD: ${strain.cbdPercent}%',
              //                 style: TextStyle(
              //                   color: Colors.white70,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 25,
              //                 ),
              //               ),
              //             ),
              //             Icon(
              //               Icons.star,
              //               color: Colors.white70,
              //               size: 22,
              //             ),
              //             Text('${strain.averageRating}',
              //                 style: TextStyle(
              //                   color: Colors.white70,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 25,
              //                 )),
              //           ],
              //         ),
              //       ),
                    Strain.getDummyHybrid.displayCard(),
                    
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  children: <Widget>[
                    Experience.dummyExperience.displayCard(),
                    Experience.dummyExperience.displayCard(),
                    Experience.dummyExperience.displayCard(),
                    Experience.dummyExperience.displayCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
//This is a dummy strain so you have data you can insert into the UI
//you access this information by using strain.name, strain.thc, etc.
class Strain {
  String name;
  double thc;
  double cbd;
  double rating;
  String date;
  String location;
  String genetics;

  Strain() {
    this.name = "Jedi Killer Kush";
    this.thc = 18.5;
    this.cbd = 2.3;
    this.rating = 4.7;
    this.date = "04/20/20";
    this.location = "Destroyer's Burger Cave";
    this.genetics = "Sativa";
  }
}
*/