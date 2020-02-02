import 'package:flutter/material.dart';
import 'Phrase.dart';
import 'Strain.dart';

class Experience {
  /* A single user cannabis experience */
  Strain strain; //the Strain of cannabis used during this Experience
  DateTime date; //the date this Experience happened on
  Phrase location; //where this Experience took place
  Phrase ingestion; //the means of ingesting the cannabis for this experience (e.g. bong, dab, joint, etc.)
  int overallRating; //a 1-5 rating for this Experience
  List<Phrase> highs; //short phrases describing the good parts of this Experience
  List<Phrase> lows; //short phrases describing the bad parts of this Experience
  String notes; //any extra information the user wants to attach to this Experience.

  Experience(this.strain,this.date,this.location,this.ingestion,this.overallRating,this.highs,this.lows,this.notes) {
    strain.addExperience(this);
  }
  
  Experience.fromString(String experienceString) {
    //creates a new Strain from the semi-colon-delimited String created by Strain.toString()
    List experienceValues = experienceString.split(";");

    //finds the first Strain with a matching name and attaches that Strain to this Experience
    //Requires that all of the Strains have already been built
    this.strain = Strain.allStrains.firstWhere((strain) => strain.name.saveString == experienceValues[0],
      orElse: () => null);

    this.date = DateTime.parse(experienceValues[1]);
    this.location = new Phrase(experienceValues[2],PhraseType.Location);
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
    
    //converts the Lists of Phrases to ampersand-deliminted Strings
    this.highs.forEach((high) => experienceString += high.saveString + '&' );
    experienceString = experienceString.substring(0,experienceString.length-1) + ';';
    this.lows.forEach((low) => experienceString += low.saveString + '&' );
    experienceString = experienceString.substring(0,experienceString.length-1) + ';';
    
    String notesString = this.notes;
    experienceString += notesString.replaceAll(';', "_sc"); //escape semicolons

    return experienceString;
  }

  Widget displayCard() {
    //TODO: implement Experience.displayCard method
    return null;
  }
}