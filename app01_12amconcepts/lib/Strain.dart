import 'package:flutter/material.dart';
import 'Phrase.dart';
import 'Experience.dart';

class Strain {
  /* A single strain of cannabis that the user has input into the app */
  Phrase name; //the name of the cannabis Strain
  List<Experience> experiences; //all of the Experiences the user has associated with this Strain
  double thcPercent; //the THC percentage (e.g. 18.2%)
  double cbdPercent; //the CDB percentage (e.g. 7.3%)
  Sub_species subSpecies; //Indica, Sativa, or Hybrid
  double averageRating; //the average of all overall_ratings from each Experience associated with this Strain

  static List<Strain> allStrains = []; //All the Strains the user has created

  //TODO: remove
  //dummy Strains for testing
  static Strain _dummyHybrid;
  static Strain _dummyIndica;
  static Strain _dummySativa;

  Strain(String name, double thc, double cbd, {Sub_species subSpecies = Sub_species.unknown}) {
    this.name = Phrase.save(name, PhraseType.Strain);
    this.thcPercent = thc;
    this.cbdPercent = cbd;
    this.subSpecies = subSpecies;

    this.experiences = [];

    Strain.allStrains.add(this); //add this new Strain to the List of all Strains
  }

  static Strain getStrainByName(String strainName) {
    //returns the Strain whose name matches strainName or returns null
    
    Strain matchingStrain;
    for(int i = 0; i < allStrains.length && matchingStrain == null; i++) {
      if(allStrains[i].name.phraseString == strainName) {
        matchingStrain = allStrains[i];
      }
    }
    return matchingStrain;
  }

  Strain.fromString (String strainString) {
    //creates a new Strain from the semi-colon-delimited String created by Strain.toString()
    List strainValues = strainString.split(";");

    this.name = Phrase.save(strainValues[0], PhraseType.Strain);
    this.thcPercent = double.parse(strainValues[1]);
    this.cbdPercent = double.parse(strainValues[2]);
    this.subSpecies = Sub_species.values.firstWhere((e) => e.toString() == strainValues[3]);

    Strain.allStrains.add(this); //add this new Strain to the List of all Strains
  }

  @override
  String toString() {
    //converts the Strain properties to a comma-delimited String
    String strainString = "";
    strainString += this.name.saveString + ";";
    strainString += this.thcPercent.toString() + ";";
    strainString += this.cbdPercent.toString() + ";";
    strainString += this.subSpecies.toString();

    return strainString;
  }

  Widget displayCard() {
    //The Strain information displayed as a card-like widget

    //sets the color of the background gradient based on the Sub_Species
    Color gradientColor;
    switch(this.subSpecies) {
      case Sub_species.Hybrid: {
        gradientColor = Color(0xFFbfd7c9); //Hybrid Green
      }
      break;

      case Sub_species.Indica: {
        gradientColor = Color(0xFFceafcc); //Indica Purple
      }
      break;
      
      case Sub_species.Sativa: {
        gradientColor = Color(0xFFedccb3); //Sativa Orange
      }
      break;

      case Sub_species.unknown: {
        gradientColor = Color(0xFFffffff); //unknown white
      }
      break;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 0, 18, 15),
      child: Container(
        //Sativa Orange Card
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(14.0),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              blurRadius: 2.0,
            ),
          ],
          gradient: LinearGradient(
            end: FractionalOffset.bottomCenter,
            begin: FractionalOffset.topLeft,
            stops: [
              .6,
              1,
            ],
            colors: [
              Color(0xFFFFFFFF),
              gradientColor, //depends on Sub_species
            ],
          ), 
        ),

        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(this.name.phraseString,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            )),
                        SizedBox(
                          height: 2,
                        ),
                        /* Strain.mostRecentLocation() is not built yet
                        TODO: uncomment Most Recent Location widget
                        Text(strain.mostRecentLocation(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            )),*/
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text('THC: ${this.thcPercent}%',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'CBD: ${this.cbdPercent}%',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black54,
                              size: 20,
                            ),
                            Text(': ${this.averageRating}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   top: 0,
                  //   width: 120,
                  //   height: 95,
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.only(
                  //             topRight: Radius.circular(14.0),
                  //             bottomRight: Radius.circular(14.0),
                  //             bottomLeft: Radius.circular(50.0),
                  //             topLeft: Radius.circular(50.0),
                  //           ),
                  //           color: Colors.green,
                  //           image: DecorationImage(
                  //             fit: BoxFit.cover,
                  //             image: NetworkImage(
                  //                 "https://images.pexels.com/photos/1466335/pexels-photo-1466335.jpeg"),
                  //           ))),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayFull() {
    //TODO: build Strain.displayFull method
    return null;
  }
  
  void addExperience(Experience newExperience) {
    //add an Experience object to the experiences property
    this.experiences.add(newExperience);
    //calculate the average_rating property
    int sum = 0;
    this.experiences.forEach((experience) => sum += experience.overallRating);
    this.averageRating = sum.toDouble() / this.experiences.length.toDouble();
  }

  String get getSubSpecies {
    switch(this.subSpecies) {
      case Sub_species.Hybrid: {
        return "Hybrid";
      }
      break;

      case Sub_species.Indica: {
        return "Indica";
      }
      break;
      
      case Sub_species.Sativa: {
        return "Sativa";
      }
      break;
      
      default:
    }
    return null;
  }

  Phrase mostRecentLocation() {
    //the location from the Experience with the most recent date
    //TODO: build Strain.mostRecentLocation method
    return null;
  }

  static Strain get getDummyHybrid {
    if(_dummyHybrid == null) {
      _dummyHybrid = Strain("Hybrid Dummy Strain",18.7,0.2, subSpecies: Sub_species.Hybrid);
    }
    return _dummyHybrid;
  }

  static Strain get getDummyIndica {
    if(_dummyIndica == null) {
      _dummyIndica = Strain("Indica Dummy Strain",15.0,5.3, subSpecies: Sub_species.Indica);
    }
    return _dummyIndica;
  }

  static Strain get getDummySativa {
    if(_dummySativa == null) {
      _dummySativa = Strain("Sativa Dummy Strain",22.1,3.5, subSpecies: Sub_species.Sativa);
    }
    return _dummySativa;
  }
}

enum Sub_species {
  Indica,
  Sativa,
  Hybrid,
  unknown
}
