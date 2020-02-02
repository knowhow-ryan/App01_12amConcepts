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

  Strain(String name, double thc, double cbd, Sub_species subSpecies) {
    this.name = Phrase.save(name, PhraseType.Strain);
    this.thcPercent = thc;
    this.cbdPercent = cbd;
    this.subSpecies = subSpecies;

    this.experiences = [];

    Strain.allStrains.add(this); //add this new Strain to the List of all Strains
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
    //TODO: build Strain.display_card method
    return null;
  }

  Widget displayFull() {
    //TODO: build Strain.display_card method
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
}

enum Sub_species {
  Indica,
  Sativa,
  Hybrid
}