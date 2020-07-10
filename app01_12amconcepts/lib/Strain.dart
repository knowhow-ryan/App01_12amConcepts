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

  static final Color HYBRID_GREEN = Color(0xFFbfd7c9);
  static final Color INDICA_PURPLE = Color(0xFFceafcc);
  static final Color SATIVA_ORANGE = Color(0xFFedccb3);
  static final Color UNKNOWN_WHITE = Color(0xFFffffff);

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

  //named constructor
  Strain.fromString (String strainString) {
    //creates a new Strain from the semi-colon-delimited String created by Strain.toString()
    List strainValues = strainString.split(";");

    this.name = Phrase.save(strainValues[0], PhraseType.Strain);
    this.thcPercent = double.parse(strainValues[1]);
    this.cbdPercent = double.parse(strainValues[2]);
    this.subSpecies = Sub_species.values.firstWhere((e) => e.toString() == strainValues[3]);

    this.experiences = [];

    Strain.allStrains.add(this); //add this new Strain to the List of all Strains
  }

  static void reload(String strainsData) {
    //rebuilds the entire allStrains list from the strainsData data String
    //strainData is a single String that contains Strain data created by toString on each line
    Strain.allStrains.clear();
    
    List<String> strainStrings = strainsData.split("\n"); //separate the data String into separate Strings for each Strain
    strainStrings.forEach((strain) {
      if(strain != null && strain.isNotEmpty) {
        Strain.fromString(strain);
      }
    });
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
    Color gradientColor = getSubSpeciesColor();
    
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        //Sativa Orange Card
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
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
              0.2,
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
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(this.name.phraseString,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                )),
                          SizedBox(width:5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45,),
                               borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(this.getSubSpecies,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                    )),
                            ),
                          ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 2,
                        // ),
                        /* Strain.mostRecentLocation() is not built yet
                        TODO: uncomment Most Recent Location widget
                        Text(strain.mostRecentLocation(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            )),*/
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Row(
                          children: bottomRowInformation(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> bottomRowInformation() {
    List<Widget> infoWidgets = [
      Text('THC: ' + this.thcPercent.toStringAsFixed(2),
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 22,
      )),
      SizedBox(
        width: 15,
      ),
      Text(
        'CBD: ' + this.cbdPercent.toStringAsFixed(2),
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      SizedBox(
        width: 15,
      )
    ];

    if(averageRating != null) {
      infoWidgets.add(Icon(
        Icons.star,
        color: Colors.black54,
        size: 22,
      ));

      infoWidgets.add(Text(': ${averageRating.toStringAsFixed(1)}',
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        )
      ));
    }

    return infoWidgets;
  }

  Color getSubSpeciesColor() {
    Color color;

    switch(this.subSpecies) {
      case Sub_species.Hybrid: {
        color = HYBRID_GREEN;
      }
      break;

      case Sub_species.Indica: {
        color = INDICA_PURPLE;
      }
      break;
      
      case Sub_species.Sativa: {
        color = SATIVA_ORANGE;
      }
      break;

      case Sub_species.unknown: {
        color = UNKNOWN_WHITE;
      }
      break;
    }

    return color;
  }

  Widget displayFull() {
    //TODO: build Strain.displayFull method
    return null;
  }
  
  void addExperience(Experience newExperience) {
    //add an Experience object to the experiences property
    this.experiences.add(newExperience);
    calculateAverageRating();
  }

  void removeExperience(Experience removeExperience) {
    //remove the Experience object from the experiences property
    this.experiences.remove(removeExperience);
    calculateAverageRating();
  }

  void calculateAverageRating() {
    //calculate the average_rating property
    int sum = 0; //the sum of the rated Experiences
    int num = 0; //the number of rated Experiences

    //TODO: remove DEBUG code below
    print("***DEBUG - calculateAverageRating***\n\nexperiences: ${this.experiences}");

    this.experiences.forEach((experience) {
      if(experience.overallRating != 0) {
        //TODO: remove DEBUG code below
        print("experience.overallRating = ${experience.overallRating}\n");
        sum += experience.overallRating;
        num += 1;
        //TODO: remove DEBUG code below
        print("sum = $sum\n\n***end DEBUG***");
      }
    });
    if(num > 0) {
      this.averageRating = sum.toDouble() / num.toDouble();
    }
    else {
      this.averageRating = 0;
    }
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

      case Sub_species.unknown: {
        return "unknown";
      }
      
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
