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

    //add the Phrase to the appropriate list
    getPhraseList(this.phraseType).add(this);
  }

  static Phrase save(String inputString, PhraseType phraseType) {
    /* determines if the phrase_string is unique within the phrase_type List
    if it is unique, a new Phrase is created and returned
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

  Widget displayPill({deleteButton = false, Function deleteCallback}) {
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

    List<Widget> pillContents = <Widget>[
      Icon(
        icon,
        color: iconColor,
        size: 13,
      ),
      SizedBox(width: 3),
      Text(this.phraseString,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 13,
      )),
    ];

    if (deleteButton) {
      pillContents.add(
        InkWell(
          child: Icon(Icons.remove_circle_outline),
          onTap: () => deleteCallback(),
        )
      );
    }

    Widget phrasePill = Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(50),
          color: Colors.white54,
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            children: pillContents,
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
  final Function callback; //pass the input of the TextField back to the parent widget
  final String hint;
  final bool multipleSelection;

  PhraseInputUI({@required this.phraseType, this.callback, this.hint, this.multipleSelection = false});

  @override
  _PhraseInputUIState createState() => _PhraseInputUIState();
}

class _PhraseInputUIState extends State<PhraseInputUI> {
  TextEditingController inputUIController = TextEditingController();

  List<Widget> matchingPhrasePills;
  List<Phrase> selectedPhrases;

  @override
  void initState() {
    super.initState();
    matchingPhrasePills = [];
    selectedPhrases = [];
    inputUIController.addListener(_inputUIListener);
  }

  void dispose() {
    inputUIController.dispose();
    super.dispose();
  }

  _inputUIListener() {
    setState(() {
      matchingPhrasePills = getMatchingPhrasePills(inputUIController.text, widget.phraseType);
      if(!widget.multipleSelection) {
        widget.callback(inputUIController.text);
      }
    });

    //widget.callback(inputUIController.text); //moved A1
  }

  List<Widget> getMatchingPhrasePills(String inputString, PhraseType phraseType){
    //returns the Phrase Pills of all Phrases whose phraseStrings contain the inputString
    
    List<Phrase> phraseList = Phrase.getPhraseList(phraseType);
    List<Widget> matchingPillList = [];

    phraseList.forEach((phrase) {
      if(phrase.phraseString.contains(Phrase._processString(inputString)) && !selectedPhrases.contains(phrase)) {
        Widget pill = InkWell(
          child: phrase.displayPill(),
          onTap: () => setState(() { //autofill the TextField when the user taps a Phrase Pill
              if (widget.multipleSelection && !selectedPhrases.contains(phrase)) {
                inputUIController.text = "";

                //add the tapped phrase to the beginning of the selected phrase list
                selectedPhrases.insert(0, phrase);
                widget.callback(phrase.phraseString);
              }
              else {
                inputUIController.text = phrase.phraseString;
                widget.callback(inputUIController.text); //moved A1
              }

          }),
          onLongPress: () {}, //TODO: define this onLongPress behavior -> offer deletion options
        );

        matchingPillList.add(pill);

      }
    });

    return matchingPillList;
  }

  List<Widget> getSelectedPhrasePills() {
    List<Widget> selectedPhrasePills = [];

    setState(() {
      selectedPhrases.forEach((phrase) => selectedPhrasePills.add(phrase.displayPill(
        deleteButton: true,
        deleteCallback: () {
          setState(() {
           selectedPhrases.remove(phrase);
          });
        }
      )));
    });

    return selectedPhrasePills;
  }

  Widget build(BuildContext buildContext) {
    Widget inputUI;
    
    if(widget.multipleSelection) {
      inputUI = Container( child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField( 
                decoration: InputDecoration(
                  
                  fillColor: Colors.white24,
                  focusColor: Colors.white70,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 15),
                ),
                controller: inputUIController,
                onSubmitted: (String userInput) {
                  setState( () {
                    Phrase inputPhrase = Phrase.save(userInput, widget.phraseType);
                    if (!selectedPhrases.contains(inputPhrase)) {
                      selectedPhrases.insert(0, inputPhrase);
                    }
                    inputUIController.text = "";
                  });
                }, // onSubmitted
              ),
            ),
            Container(height: 50.0, child: ListView( //Auto-generated list of matching Phrase Pills
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getMatchingPhrasePills(inputUIController.text, widget.phraseType),
            )),
            Container(height: 50.0, child: ListView( //list of user-selected Phrases
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getSelectedPhrasePills(),
            ))
          ]
        )
      );
    }
    else {
      inputUI = Container( child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField( 
                decoration: InputDecoration(
                  
                  fillColor: Colors.white24,
                  focusColor: Colors.white70,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 15),
                ),
                controller: inputUIController,
                onSubmitted: (userInput) => setState(() => widget.callback(userInput)),
              ),
            ),
            Container(height: 50.0, child: ListView( //Auto-generated list of matching Phrase Pills
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: matchingPhrasePills,
            )),
          ]
        )
      );
    }

    return inputUI;
  }
}