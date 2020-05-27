import 'package:flutter/material.dart';
import 'Phrase.dart';
import 'Strain.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Experience {
  /* A single cannabis experience */
  Strain strain; //the Strain of cannabis used during this Experience
  DateTime date; //the date this Experience happened on
  Phrase location; //where this Experience took place
  Phrase
      ingestion; //the means of ingesting the cannabis for this experience (e.g. bong, dab, joint, etc.)
  int overallRating; //a 1-5 integer rating for this Experience
  List<Phrase>
      highs; //short phrases describing the good parts of this Experience
  List<Phrase> lows; //short phrases describing the bad parts of this Experience
  String
      notes; //any extra information the user wants to attach to this Experience.

  //TODO: remove
  //dummy Experience for testing
  static Experience _dummyExperience;

  Experience(this.strain, this.date, this.location, this.ingestion,
      this.overallRating, this.highs, this.lows, this.notes) {
    strain.addExperience(this);
  }

  Experience.fromString(String experienceString) {
    //creates a new Experience from the semi-colon-delimited String created by Experience.toString()
    List experienceValues = experienceString.split(";");

    //finds the first Strain with a matching name and attaches that Strain to this Experience
    //Requires that all of the Strains have already been built
    this.strain = Strain.allStrains.firstWhere(
        (strain) => strain.name.saveString == experienceValues[0],
        orElse: () => null);

    this.date = DateTime.parse(experienceValues[1]);
    this.location = new Phrase(experienceValues[2], PhraseType.Location);
    this.ingestion = new Phrase(experienceValues[3], PhraseType.Ingestion);
    this.overallRating = int.parse(experienceValues[4]);

    String highsString = experienceValues[5];
    List highs = highsString.split('&');
    this.highs = List<Phrase>();
    highs.forEach((high) => this.highs.add(new Phrase(high, PhraseType.High)));

    String lowsString = experienceValues[6];
    List lows = lowsString.split('&');
    this.lows = List<Phrase>();
    lows.forEach((low) => this.lows.add(new Phrase(low, PhraseType.Low)));

    this.notes = experienceValues[7];
  }

  @override
  String toString() {
    //converts the Experience properties to a semicolon-delimited String
    String experienceString = "";

    experienceString += this.strain.name.saveString + ';';
    experienceString += this.date.toString() + ';';
    experienceString += this.location.saveString + ';';
    experienceString += this.ingestion.saveString + ';';
    experienceString += this.overallRating.toString() + ';';

    //converts the Lists of Phrases to ampersand-delimited Strings
    this.highs.forEach((high) => experienceString += high.saveString + '&');
    experienceString =
        experienceString.substring(0, experienceString.length - 1) + ';';
    this.lows.forEach((low) => experienceString += low.saveString + '&');
    experienceString =
        experienceString.substring(0, experienceString.length - 1) + ';';

    String notesString = this.notes;
    experienceString += notesString.replaceAll(';', "_sc"); //escape semicolons

    return experienceString;
  }

  List<Widget> get highsPillList {
    //get a list of all of the Phrase pill widgets from the highs List
    List<Widget> widgetList = [];
    this.highs.forEach((high) => widgetList.add(high.displayPill()));
    return widgetList;
  }

  List<Widget> get lowsPillList {
    //get a list of all of the Phrase pill widgets from the highs List
    List<Widget> widgetList = [];
    this.lows.forEach((low) => widgetList.add(low.displayPill()));
    return widgetList;
  }

  Widget displayCard(BuildContext context) {
    Widget card = Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
               
                Text(
                  this.date.month.toString() +
                      '/' +
                      this.date.day.toString() +
                      '/' +
                      this.date.year.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  this.location.phraseString +
                      '  ' +
                      this.ingestion.phraseString,
                  style: TextStyle(
                    color: Colors.white,
                    
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
             Wrap(
              //highs
              children: this.highsPillList,
            ),
            Wrap(
                //lows
                children: this.lowsPillList),
                 Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          //edit icon
                          FontAwesomeIcons.solidStar,
                          color: Colors.white,
                          size: 13,
                        ),
                        Text(
                          ' : ' + this.overallRating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    //notes
                    this.notes,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.white,
                )),
              ],
            )
          ]),
    );

    return card;
  }

  static Experience get dummyExperience {
    if (_dummyExperience == null) {
      _dummyExperience = Experience(
          Strain.getDummyHybrid,
          DateTime.now(),
          Phrase("dummy location", PhraseType.Location),
          Phrase("dummy ingestion", PhraseType.Ingestion),
          4,
          [
            Phrase("dummy high 1", PhraseType.High),
            Phrase("dummy high 2", PhraseType.High)
          ],
          [
            Phrase("dummy low 1", PhraseType.Low),
            Phrase("dummy low 2", PhraseType.Low)
          ],
          "woah dude. that was epic");
    }
    return _dummyExperience;
  }
}
