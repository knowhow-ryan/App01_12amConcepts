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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
                    Row(
                      children: <Widget>[
                        Padding(
                           padding: const EdgeInsets.only(right:4,),
                          child: Text(
                            experience.date,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      
                    Padding(
                       padding: const EdgeInsets.only(left:4,right:4,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("happy",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  )),
                            ),
                          )),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left:4,right:4,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("stoney",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  )),
                            ),
                          )),
                    ),
                    ],
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(bottom:10,top:5,),
                      child: Text(
                          'Donec nec diam sit amet dui tristique luctus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac lorem tellus. Suspendisse pharetra purus sit amet nulla suscipit, ac commodo metus ornare. Sed dolor lectus, volutpat nec ipsum interdum, ultrices iaculis nunc. In at consectetur ligula, quis viverra lectus. Maecenas lacinia ex sed blandit tincidunt. Vivamus egestas leo et sapien sollicitudin tincidunt.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          )),
                    ),
                        SizedBox(height:15,),
        ],
      )
    );}}


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

