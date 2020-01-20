import 'package:flutter/material.dart';



class ExperienceCard extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Experience experience;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  ExperienceCard(this.experience);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height:5,),
                    Text(
                      experience.date,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(50),
                                color: Colors.white70,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text("happy",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                      )),
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(50),
                                color: Colors.white70,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text("stoney",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                      )),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                        'Donec nec diam sit amet dui tristique luctus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac lorem tellus. Suspendisse pharetra purus sit amet nulla suscipit, ac commodo metus ornare. Sed dolor lectus, volutpat nec ipsum interdum, ultrices iaculis nunc. In at consectetur ligula, quis viverra lectus. Maecenas lacinia ex sed blandit tincidunt. Vivamus egestas leo et sapien sollicitudin tincidunt.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        )),
        ],
      )
    );}}

//This is a dummy strain so you have data you can insert into the UI
//you access this information by using strain.name, strain.thc, etc.
// class Strain {
//   String name;
//   double thc;
//   double cbd;
//   double rating;
//   String date;
//   String location;
//   String genetics;

//   Strain() {
//     this.name = "Jedi Killer Kush";
//     this.thc = 18.5;
//     this.cbd = 2.3;
//     this.rating = 4.7;
//     this.date = "04/20/20";
//     this.location = "Destroyer's Burger Cave";
//     this.genetics = "Sativa";
//   }
// }

class Experience {
  String text;
  String date;
  String location;

  Experience() {
    this.text = "This is my test text.";
    this.date = "04/20/20";
    this.location = "Cole Cave";
  }
}

