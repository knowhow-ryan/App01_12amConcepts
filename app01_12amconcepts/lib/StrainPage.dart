import 'package:flutter/material.dart';
import 'TopSearch.dart';
import 'Experience.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';

class StrainPage extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //TODO: does this need to be a StatefulWidget so that the user can edit the various Strain and Experience fields?

  final Strain strain; //container for all of the strain information, like name, location, thc, etc.

  StrainPage(this.strain); //constructor that pulls in Strain object information and puts it in the strain container above

  List<Widget> getExperiences() {
    //generate a List of Experience Cards to display below the Strain information
    List<Widget> experiences = [];

    //TODO: when this becomes a StatefulWidget, this will need to be wrapped in a setState()
    strain.experiences.forEach((experience) => experiences.add(experience.displayCard()));

    return experiences;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container( //page background
            decoration: BoxDecoration( //Starting Gradient with Smoke Background
              gradient: LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                stops: [
                  .05,
                  .45,
                ],
                colors: [
                  strain.getSubSpeciesColor(),
                  Color(0xFF000000),
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
            
          Column( //the page content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopSearch(), //top search bar
            
              strain.displayCard(), //the current Strain
                  
              Expanded(// list of all of the Strain's Experiences
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  children: getExperiences(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}