import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Phrase {
  /* short phrase the user has input to describe their Experiences
  This class makes it easy for the user to use the same phrasing consistently
  This allows for auto-fill features as well as searching across the app by particular Phrases*/
  static List<Phrase> strains = []; //all of the Phrases used in the Strain name field of all Experiences
  static List<Phrase> highs = []; //all of the Phrases used in the highs field of all Experiences
  static List<Phrase> lows = []; //all of the Phrases used in the lows field of all Experiences
  static List<Phrase> locations = []; //all of the Phrases used in the location field of all Experiences
  static List<Phrase> ingestions= []; //all of the Phrases used in the ingestion field of all Experiences

  String phraseString; //the actual short phrase provided by the user
  PhraseType phraseType; //which Phrase list will this go into?

  //basic constructor
  Phrase(newPhraseString, this.phraseType) {
    this.phraseString = _processString(newPhraseString);
    strains.add(this);
  }

  static Phrase save(String inputString, PhraseType phraseType) {
    /* determines if the phrase_string is unique within the phrase_type List
    if it is unique, a new Phrase is created, added to the list, and returned
    if it is not unique, the matching Phrase is returned*/
    Phrase phrase;
    List<Phrase> phraseList = Phrase.getPhraseList(phraseType);

    inputString = _processString(inputString);
    
    //search the appropriate Phrase List based on the Phrase type
    //return either the matching Phrase or a new Phrase
    phrase = phraseList.firstWhere((phraseItem) => phraseItem.phraseString == inputString, orElse: () => new Phrase(inputString, phraseType));

    return phrase;
  }

  String get saveString {
    //processes and returns the phrase_string for safe saving to semicolon- and ampersand-deliminted list
    String saveString = this.phraseString;
    saveString.replaceAll('&', '_and');
    return saveString.replaceAll(';', "_sc");
  }

  static String _processString(String rawString) {
    //standardize all strings to aid in removing duplicates
    String processedString = "";

    //remove extraneous whitespace
    rawString.replaceAll('\t', " ");
    rawString.replaceAll('\n', " ");

    //remove all extra spaces
    List<String> words = rawString.split(" ");
    words.forEach((word) => processedString += word + ' ');
    processedString = processedString.trim();

    processedString = processedString.toLowerCase();

    processedString.replaceAll("_and", '&');
    processedString.replaceAll("_sc", ';');

    return processedString;
  }

  static List<Phrase> getPhraseList(PhraseType phraseType) {
    //returns the Phrase List associated with the input PhraseTypes
    switch(phraseType) {
      case PhraseType.Strain: {return Phrase.strains;}
      break;

      case PhraseType.High: {return Phrase.highs;}
      break;

      case PhraseType.Low: {return Phrase.lows;}
      break;

      case PhraseType.Location: {return Phrase.locations;}
      break;

      case PhraseType.Ingestion: {return Phrase.ingestions;}
      break;
    }

    return null;
  }

  Widget displayPill() {
    IconData icon;
    MaterialColor iconColor;

    //set the icon and iconColor based on the PhraseType
    switch(this.phraseType) {
      case PhraseType.Strain: {
        icon = FontAwesomeIcons.acquisitionsIncorporated;
        iconColor = Colors.yellow;
      }
      break;

      case PhraseType.High: {
        icon = FontAwesomeIcons.smileBeam;
        iconColor = Colors.green;
      }
      break;

      case PhraseType.Low: {
        icon = FontAwesomeIcons.mehBlank;
        iconColor = Colors.red;
      }
      break;

      case PhraseType.Location: {
        icon = FontAwesomeIcons.home;
        iconColor = Colors.brown;
      }
      break;

      case PhraseType.Ingestion: {
        icon = FontAwesomeIcons.bong;
        iconColor = Colors.teal;
      }
      break;

      default: {
        icon = FontAwesomeIcons.fire;
        iconColor = Colors.orange;
      }
      break;
    }

    Widget phrasePill = Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(50),
          color: Colors.white70,
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
                size: 15,
              ),
              SizedBox(width: 3),
              Text(this.phraseString,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
              )),
            ],
          ),
      )),
    );
    
    return phrasePill;
  }
}

enum PhraseType {
  Strain,
  High,
  Low,
  Location,
  Ingestion
}

class PhraseInputUI extends StatefulWidget {
  final PhraseType phraseType;
  final Function callback;

  PhraseInputUI({@required this.phraseType, this.callback});

  @override
  _PhraseInputUIState createState() => _PhraseInputUIState();
}

class _PhraseInputUIState extends State<PhraseInputUI> {
  TextEditingController inputUIController = TextEditingController();

  List<Widget> matchingPhrasePills;

  @override
  void initState() {
    super.initState();
    matchingPhrasePills = [];
    inputUIController.addListener(_inputUIListener);
  }

  void dispose() {
    inputUIController.dispose();
    super.dispose();
  }

  _inputUIListener() {
    _getMatchingPhrasePills(inputUIController.text, widget.phraseType, callback: widget.callback);
    widget.callback(inputUIController.text);
  }

  void _getMatchingPhrasePills(String inputString, PhraseType phraseType, {Function callback}){
    //returns the Phrase Pills of all Phrases whose phraseStrings contain the inputString
    
    List<Phrase> phraseList = Phrase.getPhraseList(phraseType);
    List<Widget> matchingPillList = [];

    phraseList.forEach((phrase) {
      if(phrase.phraseString.contains(Phrase._processString(inputString))) {
        Widget pill = InkWell(
          child: phrase.displayPill(),
          onTap: () => setState(() { //autofill the Strain TextField when the user taps a Strain name Phrase Pill
              inputUIController.text = phrase.phraseString;
          }),
          onLongPress: () {}, //TODO: define this onLongPress behavior -> offer deletion options
        );

        matchingPillList.add(pill);
      }
    });

    setState(() {
      matchingPhrasePills = matchingPillList;
    });
  }

  Widget build(BuildContext buildContext) {
    return Container( child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: TextField( 
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: "strain name",
                hintStyle: TextStyle(fontSize: 18),
              ),
              controller: inputUIController,
            ),
          ),
          Container(height: 50.0, child: ListView( //Auto-generated list of matching Phrase Pills
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: matchingPhrasePills,
          ))
        ]
      )
    );
  }
}