import 'dart:io';
import 'Strain.dart';

import 'package:path_provider/path_provider.dart';

class DataControl {
  //a static class to control data IO

  static Future<void> saveStrains() async {
    //saves each Strain's information to a new line of the Strain data file
    File strainFile = await _StrainFile;
    String saveString = "";

    Strain.allStrains.forEach((strain) => saveString += strain.toString() + "\n");

    strainFile.writeAsString(saveString);
  }

  static Future<String> debugLoadStrains() async {
    //loads the Strain info file and returns the contents as a String
    File strainFile = await _StrainFile;

    return strainFile.readAsString();
  }

  static Future<File> get _StrainFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return File('$path/Strains.txt');
  }
}