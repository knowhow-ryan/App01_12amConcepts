import 'package:app01_12amconcepts/DataControl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'TopSearch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'dart:async';
import 'NewExperiencePage.dart';

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
    List<Widget> experienceCards = [];

    setState(() {
      //update the Experience card widgets
      strain.experiences.forEach((experience) {
        //make a card widget for each experience
        //Completer and Future for connecting the Dismissible widget to the confirmation button in the Dismissble's background
        Completer userDeleteReaction = new Completer();

        experienceCards.add(Dismissible(
          key: Key(experience.date.toString()), //Dismissibles require a unique Key for its child;
          child: experience.displayCard(context),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Remove the item from the data source.
            setState(() {
              strain.experiences.remove(experience);
            });
            //update the Data File
            DataControl.saveExperiences();

            // Then show a snackbar.
            //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismmissed")));
          },
          confirmDismiss: (direction) async {
            userDeleteReaction = new Completer();

            return await userDeleteReaction.future; //return the user's selection from the delete confirmation panel
          },
          background: Container(
            // delete confirmation panel
            color: Colors.red,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
              InkWell(
                // cancel the delete action
                child: Icon(Icons.cancel),
                onTap: (() => userDeleteReaction.complete(false)),
              ),
              InkWell(
                  // edit the swiped Experience
                  child: Icon(
                    FontAwesomeIcons.pencilAlt,
                    color: Colors.white70,
                    size: 13,
                  ),
                  onTap: () {
                    userDeleteReaction.complete(false);
                    Navigator.of(context).push(_createRoute(destination: NewExperiencePage(editExperience: experience)));
                  }),
              InkWell(
                // confirm the delete action
                child: Icon(Icons.delete_outline),
                onTap: (() => userDeleteReaction.complete(true)),
              )
            ]),
          ),
        ));
      });
    });

    return experienceCards;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            //page background
            decoration: BoxDecoration(
              //Starting Gradient with Smoke Background
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
            child: Image(
              image: AssetImage('graphics/Smokey-Background-Side.png'),
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              colorBlendMode: BlendMode.overlay,
            ),
          ),
          Column(
            //the page content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopSearch(), //top search bar

              strain.displayCard(), //the current Strain

              Expanded(
                // list of all of the Strain's Experiences
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

Route _createRoute({destination}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destination,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}
