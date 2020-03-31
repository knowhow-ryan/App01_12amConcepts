import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'TopSearch.dart';
import 'Experience.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';

class StrainPage extends StatefulWidget {
  //displays the Strain information along with cards for each Experience with this Strain

  final Strain strain; //container for all of the strain information, like name, location, thc, etc.

  StrainPage(this.strain); //constructor that pulls in Strain object information and puts it in the strain container above

  @override
  StrainPageState createState() => StrainPageState();
}

class StrainPageState extends State<StrainPage> {

  Strain strain;

  @override
  void initState() {
    super.initState();

    strain = widget.strain;
  }

  void dispose() {
    super.dispose();
  }

  List<Widget> getExperiences(BuildContext context) {
    //generate a List of Experience Cards to display below the Strain information
    List<Widget> experiences = [];

    setState(() { //update the Experience card widgets
      strain.experiences.forEach((experience) { //make a card widget for each experience
        experiences.add(Dismissible(
          key: Key(experience.date.toString()), //Dismissibles require a unique Key for its child; 
          child: experience.displayCard(context),
          onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  strain.experiences.remove(experience);
                });

                // Then show a snackbar.
                //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismmissed")));
              },
          background: Container(
            color: Colors.red,
            child: Text("deleted"),
          ),
        ));
      });
    });

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
                  children: getExperiences(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}