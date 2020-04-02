import 'dart:developer';

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
  static List<Phrase> ingestions = []; //all of the Phrases used in the ingestion field of all Experiences

  String phraseString; //the actual short phrase provided by the user
  PhraseType phraseType; //which Phrase list will this go into?

  //basic constructor
  Phrase(newPhraseString, this.phraseType) {
    //creates a Phase object, but does not add it to static Lists for each PhraseType
    //to create a new Phrase object and add it to the appropriate static List, use Phrase.save
    this.phraseString = _processString(newPhraseString);
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
    phrase = phraseList.firstWhere(
        (phraseItem) => phraseItem.phraseString == inputString,
        orElse: () {
          Phrase newPhrase = (new Phrase(inputString, phraseType));
          phraseList.add(newPhrase);
          return newPhrase;
        }
      );

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

  static Phrase getPhraseByString(String targetString, PhraseType phraseType) {
    return getPhraseList(phraseType).firstWhere(
      (phraseItem) => phraseItem.phraseString == targetString,
        orElse: () => null
    );
  }

  static List<Phrase> getPhraseList(PhraseType phraseType) {
    //returns the Phrase List associated with the input PhraseTypes
    switch (phraseType) {
      case PhraseType.Strain:
        {
          return Phrase.strains;
        }
        break;

      case PhraseType.High:
        {
          return Phrase.highs;
        }
        break;

      case PhraseType.Low:
        {
          return Phrase.lows;
        }
        break;

      case PhraseType.Location:
        {
          return Phrase.locations;
        }
        break;

      case PhraseType.Ingestion:
        {
          return Phrase.ingestions;
        }
        break;
    }

    return null;
  }

  Widget displayPill({deleteButton = false, Function deleteCallback}) {
    IconData icon;
    MaterialColor iconColor;

    //set the icon and iconColor based on the PhraseType
    switch (this.phraseType) {
      case PhraseType.Strain:
        {
          icon = FontAwesomeIcons.cannabis;
          iconColor = Colors.grey;
        }
        break;

      case PhraseType.High:
        {
          icon = FontAwesomeIcons.smileBeam;
          iconColor = Colors.lightGreen;
        }
        break;

      case PhraseType.Low:
        {
          icon = FontAwesomeIcons.mehBlank;
          iconColor = Colors.deepOrange;
        }
        break;

      case PhraseType.Location:
        {
          icon = FontAwesomeIcons.mapMarkerAlt;
          iconColor = Colors.deepPurple;
        }
        break;

      case PhraseType.Ingestion:
        {
          icon = FontAwesomeIcons.fireAlt;
          iconColor = Colors.amber;
        }
        break;

      default:
        {
          icon = FontAwesomeIcons.joint;
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
      //SizedBox(width: 15),
      Padding(
        padding: const EdgeInsets.only(left:4.0),
        child: Text(this.phraseString,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            )),
      ),
    ];

    if (deleteButton) {
      pillContents.add(InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(
            Icons.remove_circle_outline,
            color: Colors.white,
          ),
        ),
        onTap: () => deleteCallback(),
      ));
    }

    Widget phrasePill = Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(50),
            color: Colors.white12,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              children: pillContents,
              mainAxisSize: MainAxisSize.min,
            ),
          ))
    );

    return phrasePill;
  }
}

enum PhraseType { Strain, High, Low, Location, Ingestion }

class InitialValueException implements Exception {
  static get errorMessage => "InitialValueException - multipleSelection set to false, but iniitalValues contains more than one element.";
}

class PhraseInputUI extends StatefulWidget {
  final PhraseType phraseType;
  final Function callback; //pass the input of the TextField back to the parent widget
  final Function deleteCallback; //notify the parent Widget that a Phrase has been deleted from the selectedPhrases
  final String hint; //hint to display in the TextField before any user input
  final bool multipleSelection;
  final bool enforceUniqueInput;
  final List<Phrase> initialValues; //optional initial values for the user input TextField or the selectedPhrases
  //multipleSelecion must be true to accept more than one initial value
  final Color warningTextColor;
  final String warningText; //text to display if enforceUniqueInput is true and the user inputs a Phrase that already exists

  PhraseInputUI(
      {@required this.phraseType,
      this.callback,
      this.deleteCallback,
      this.hint,
      this.multipleSelection = false,
      this.enforceUniqueInput = false,
      this.initialValues,
      this.warningTextColor = Colors.white,
      this.warningText = ""});

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
    
    //check if there are initialValues that need to be distrubuted to the inputUIController.text or the selectedPhrases
    if(widget.initialValues != null && widget.initialValues != []) { //if there are initialvalues
      if(widget.initialValues.length == 1 && !widget.multipleSelection) { //and if there is only one for a single selection UI
        inputUIController.text = widget.initialValues[0].phraseString; //put that initialValue in the TextField
        selectedPhrases = [];
      }
      else if (widget.multipleSelection) { //or if multipleSelection is on
        selectedPhrases = widget.initialValues;//put the initialValues in the selectedPhrases
      }
      else {
        selectedPhrases = []; //initialize selectedPhrases
        try { //throw an exception if there is more than one initialValue but multipleSelection is off/false
          if(widget.multipleSelection == false && widget.initialValues.length > 1) {throw InitialValueException;}
        }
        on InitialValueException {log(InitialValueException.errorMessage);}
      }
    }
    else {
      selectedPhrases = []; //initialize selectedPhrases
    }
    
    inputUIController.addListener(_inputUIListener);
  }

  void dispose() {
    inputUIController.dispose();
    super.dispose();
  }

  _inputUIListener() {
    setState(() {
      matchingPhrasePills = getMatchingPhrasePills(inputUIController.text, widget.phraseType);
      if(widget.multipleSelection == false) {
        widget.callback(inputUIController.text);
      }
    });

    //widget.callback(inputUIController.text); //moved A1
  }

  List<Widget> getMatchingPhrasePills( String inputString, PhraseType phraseType) {
    //returns the Phrase Pills of all Phrases whose phraseStrings contain the inputString

    List<Phrase> phraseList = Phrase.getPhraseList(phraseType);
    List<Widget> matchingPillList = [];

    phraseList.forEach((phrase) {
      if (phrase.phraseString.contains(Phrase._processString(inputString)) && !selectedPhrases.contains(phrase)) {
        Widget pill = InkWell(
          child: phrase.displayPill(),
          onTap: () => setState(() {
            //autofill the TextField when the user taps a Phrase Pill
            if (widget.multipleSelection && !selectedPhrases.contains(phrase)) {
              inputUIController.text = "";

              //add the tapped phrase to the beginning of the selected phrase list
              selectedPhrases.insert(0, phrase);
              widget.callback(phrase.phraseString);
            } else if(widget.multipleSelection == false) {
              inputUIController.text = phrase.phraseString;
              widget.callback(inputUIController.text); //moved A1
            }
          }),
          onLongPress:
              () {}, //TODO: define this onLongPress behavior -> offer deletion options
        );

        matchingPillList.add(pill);
      }
    });

    return matchingPillList;
  }

  List<Widget> getSelectedPhrasePills() {
    List<Widget> selectedPhrasePills = [];

    if (selectedPhrases != null) {
      setState(() {
        selectedPhrases.forEach((phrase) => selectedPhrasePills.add(phrase.displayPill(
                deleteButton: true,
                deleteCallback: () {
                  setState(() {
                    selectedPhrases.remove(phrase);
                    widget.deleteCallback(phrase);
                  });
        })));
      });
    }

    return selectedPhrasePills;
  }

  Widget getUniqueInputWarning() {
    String warningText = "";

    String userInput = Phrase._processString(inputUIController.text);

    //if the user input matches a Phrase other than the initial value phrase => set the warningText
    if(Phrase.getPhraseByString(userInput, widget.phraseType) != null && userInput != widget.initialValues[0].phraseString) {
      warningText = widget.warningText;
    }

    return Container(
      child: Center( child: Text(
        warningText,
        style: TextStyle(color: widget.warningTextColor),
      ))
    );
  }

  Widget build(BuildContext buildContext) {
    Widget inputUI;

    if (widget.multipleSelection) {
      inputUI = Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  )),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xFF51B579),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                controller: inputUIController,
                onSubmitted: (String userInput) {
                  setState( () {
                    Phrase inputPhrase = Phrase.save(userInput, widget.phraseType);
                    if (!selectedPhrases.contains(inputPhrase)) {
                      selectedPhrases.insert(0, inputPhrase);
                      widget.callback(inputPhrase);
                    }
                    inputUIController.text = "";
                  });
                }, // onSubmitted
              ),
            ),
            Container(
                height: 50.0,
                child: ListView(
                  //Auto-generated list of matching Phrase Pills
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: getMatchingPhrasePills(
                      inputUIController.text, widget.phraseType),
                )),
            Container(
                height: 50.0,
                child: ListView(
                  //list of user-selected Phrases
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: getSelectedPhrasePills(),
                ))
          ]));
    }
    else if (widget.enforceUniqueInput) {
      inputUI = Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  )),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xFF51B579),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                controller: inputUIController,
                onSubmitted: (userInput) => setState(() => widget.callback(userInput)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                  height: 50.0,
                  child: getUniqueInputWarning(),
              ),
            ),
      ]));
    }
    else {
      inputUI = Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  )),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xFF51B579),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                controller: inputUIController,
                onSubmitted: (userInput) => setState(() => widget.callback(userInput)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                  height: 50.0,
                  child: ListView(
                    //Auto-generated list of matching Phrase Pills
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: matchingPhrasePills,
                  )),
            ),
      ]));
    }
    
    return inputUI;
  }
}
