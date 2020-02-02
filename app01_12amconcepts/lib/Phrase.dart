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
  Phrase(this.phraseString, this.phraseType);

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

    processedString.toLowerCase();

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
    //TODO: build Phrase.display_pill method
    return null;
  }

  Widget inputUI() {
    //TODO: build Phrase.input_ui method
    return null;
  }
}

enum PhraseType {
  Strain,
  High,
  Low,
  Location,
  Ingestion
  }