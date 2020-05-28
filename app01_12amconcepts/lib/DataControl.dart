import 'dart:io';
import 'Strain.dart';

import 'package:path_provider/path_provider.dart';

class DataControl {
  //a static class to control data IO

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

    experienceFile.writeAsString(saveString);

    
    await debugloadExperiences(); //TODO: remove this debug code
  }

  static Future<String> loadStrains() async {
    //loads the Strain info file and returns the contents as a String within a Future
    File strainFile = await _StrainFile;

    return strainFile.readAsString();
  }

  static void debugloadExperiences() async {
    //loads the Experience info file and prints it to the console as a debug message
    //TODO: convert this to the actual loadExperiences
    File experienceFile = await _ExperienceFile;
    String experiencesString = await experienceFile.readAsString();


    print("\n***DEBUG - debugloadExperiences***\n\n" + experiencesString + "\n*** *** *** *** ***\n");
  }
}