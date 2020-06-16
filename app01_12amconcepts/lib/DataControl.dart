import 'dart:async';
import 'dart:io';
import 'package:app01_12amconcepts/Experience.dart';

import 'Strain.dart';

import 'package:path_provider/path_provider.dart';

class DataControl {
  //a static class to control data IO

  static String strainsData;
  static String experiencesData;

  static Future<File> get _StrainFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return File('$path/Strains.txt');
  }

  static Future<File> get _ExperienceFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return File('$path/Experiencess.txt');
  }

  static Future<void> saveStrains() async {
    //saves each Strain's information to a new line of the Strain data file
    File strainFile = await _StrainFile;
    String saveString = "";

    Strain.allStrains.forEach((strain) => saveString += strain.toString() + "\n");

    saveString = saveString.trim();
    strainsData = saveString; //store the most up-to-date data string

    strainFile.writeAsString(saveString);
  }

  static Future<void> saveExperiences() async {
    //saves each Experience's information to a new line of the Experience data file
    File experienceFile = await _ExperienceFile;
    String saveString = "";

    //write each Experience to a separete line of saveString
    Strain.allStrains.forEach((strain) {
      strain.experiences.forEach((experience) => saveString += experience.toString() + "\n");
    });

    saveString = saveString.trim();
    experiencesData = saveString; //store the most up-to-date data string

    experienceFile.writeAsString(saveString);
  }

  static Future<String> loadStrains() async {
    //loads the Strain info file and returns the contents as a String within a Future
    File strainFile = await _StrainFile;

    return strainFile.readAsString();
  }

  static Future<String> loadExperiences() async {
    //loads the Strain info file and returns the contents as a String within a Future
    File experienceFile = await _ExperienceFile;

    return experienceFile.readAsString();
  }

  static Future<bool> loadAll() async {
    //loads both Strain and Experience into their data structures, returning a boolean to indicate loading is complete
    Completer<bool> dataLoaded = new Completer(); //watches for Strain and Experience data to be loaded.

    loadStrains().then((strains) {
      strainsData = strains;  //store the most up-to-date Strain data string
      Strain.reload(strainsData);

      loadExperiences().then((experiences) {
        //TODO: remove DEBUG code below
        print("***DataControl.loadAll() - loadExperiences.then***\n\n" + experiences);
        experiencesData = experiences;  //store the most up-to-date data string
        Experience.reload(experiencesData);

        dataLoaded.complete(true);
      },

      onError: (error) => dataLoaded.completeError(error));
    },

    onError: (error) => dataLoaded.completeError(error));

    return dataLoaded.future;
  }
}