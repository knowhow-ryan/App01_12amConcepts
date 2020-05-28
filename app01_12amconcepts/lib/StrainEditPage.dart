import 'package:flutter/material.dart';
import 'Strain.dart';
import 'Phrase.dart';
import 'SubspeciesPickerButton.dart';
import 'StrainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DataControl.dart';

class StrainEditPage extends StatefulWidget{
  //A page for the user to edit the values of an existing Strain
  final Strain editStrain;

  StrainEditPage(this.editStrain) : super();

  @override
  StrainEditPageState createState() => StrainEditPageState();
}

class StrainEditPageState extends State<StrainEditPage> {

  bool userInputActive = true;

  double _thcSliderValue = 0.0;
  double _cbdSliderValue = 0.0;

  String userStrainName;
  Sub_species subspecies = Sub_species.unknown;
  String _thcValidValue ="0.0"; //the most recent valid value for the THC percentage TextField
  String _cbdValidValue = "0.0"; //the most recent valid value for the CBD percentage TextField

  Widget sativaButton;
  Widget indicaButton;
  Widget hybridButton;

  Function setTHC;
  Function setCBD;
  Function setRating;

  TextEditingController thcPercentController = new TextEditingController();
  TextEditingController cbdPercentController = new TextEditingController();

  List<Phrase> userHighs;
  List<Phrase> userLows;

  Color warningTextColor = Colors.white.withOpacity(0.9);

  @override
  void initState() {
    super.initState();

    setTHC = (newPercentage) {
      if (newPercentage == null) {
        newPercentage = 0.0;
      }
      setState(() {
        _thcSliderValue = newPercentage;
        if (newPercentage == 0.0) {
          thcPercentController.text = "";
        } else {
          thcPercentController.text = newPercentage.toStringAsFixed(1);
        }
      });
    };

    setCBD = (newPercentage) {
      if (newPercentage == null) {
        newPercentage = 0.0;
      }
      setState(() {
        _cbdSliderValue = newPercentage;
        if (newPercentage == 0.0) {
          cbdPercentController.text = "";
        } else {
          cbdPercentController.text = newPercentage.toStringAsFixed(1);
        }
      });
    };

    thcPercentController.addListener(() {
      if (double.tryParse(thcPercentController.text) == null) {
        thcPercentController.text = "";
        setState(() => _thcSliderValue = 0.0);
      } else {
        setState(
            () => _thcSliderValue = double.tryParse(thcPercentController.text));
      }
    });

    cbdPercentController.addListener(() {
      if (double.tryParse(cbdPercentController.text) == null) {
        cbdPercentController.text = "";
        setState(() => _cbdSliderValue = 0.0);
      } else {
        setState(
            () => _cbdSliderValue = double.tryParse(cbdPercentController.text));
      }
    });
    
    //initialize all of the Strain field values
    userStrainName = widget.editStrain.name.phraseString;
    subspecies = widget.editStrain.subSpecies;
    _thcSliderValue = widget.editStrain.thcPercent;
    thcPercentController.text = _thcSliderValue.toString();
    _thcValidValue = _thcSliderValue.toString();
    _cbdSliderValue = widget.editStrain.cbdPercent;
    cbdPercentController.text = _cbdSliderValue.toString();
    _cbdValidValue = _cbdSliderValue.toString();
    //userInputActive = false;

    toggleSubSpeciesButtons(subSpecies: widget.editStrain.subSpecies);
  }

  void dispose() {
    thcPercentController.dispose();
    cbdPercentController.dispose();
    super.dispose();
  }

  String validatePercentInput(inputString, validString) {
    /*validate that the inputString represents a double value between 0 and 100, inclusive.
    If the value is invalid, return the input validString*/
    double inputDouble = double.tryParse(inputString);

    if (inputString == "") {
      validString = inputString;
    } else if (inputDouble != null) {
      if (inputDouble >= 0.0 && inputDouble <= 100.0) {
        validString = inputString;
      }
    }

    return validString;
  }

  void toggleSubSpeciesButtons({Sub_species subSpecies = Sub_species.unknown}) {
    //deactivates all of the SubspeciesPickerButtons, then activates the button for the input sub_species
    //if sub_species is unknown, then no button is activated

    sativaButton =
        SubspeciesPickerButton(subspecies: Sub_species.Sativa, selected: false);
    indicaButton =
        SubspeciesPickerButton(subspecies: Sub_species.Indica, selected: false);
    hybridButton =
        SubspeciesPickerButton(subspecies: Sub_species.Hybrid, selected: false);

    switch (subSpecies) {
      case Sub_species.Hybrid:
        {
          hybridButton = SubspeciesPickerButton(
              subspecies: Sub_species.Hybrid, selected: true);
        }
        break;

      case Sub_species.Indica:
        {
          indicaButton = SubspeciesPickerButton(
              subspecies: Sub_species.Indica, selected: true);
        }
        break;

      case Sub_species.Sativa:
        {
          sativaButton = SubspeciesPickerButton(
              subspecies: Sub_species.Sativa, selected: true);
        }
        break;

      case Sub_species.unknown:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //save all of the new Strain information so long as the Strain name is valid, otherwise do nothing
          if(userInputActive) {
            widget.editStrain.name = Phrase.save(userStrainName, PhraseType.Strain);
            widget.editStrain.subSpecies = subspecies;
            widget.editStrain.thcPercent = _thcSliderValue;
            widget.editStrain.cbdPercent = _cbdSliderValue;
            
            DataControl.saveStrains();
            
            //go to the Strain page to display the newly updated information
            Navigator.of(context).push(_createRoute(widget.editStrain));
          }
          else {
            setState( () => warningTextColor = Colors.red[500]);
          }

          

          //TODO: remove the debug code below
          //DEBUG: print the Strain and Experience information to the console from the generated Strain and Experience objects
          print("***DEBUG***\nStrain: ${widget.editStrain.name.phraseString}\nSubspecies: ${widget.editStrain.subSpecies.toString()}\nTHC: ${widget.editStrain.thcPercent}\tCBD: ${widget.editStrain.cbdPercent}\nAverage Rating: ${widget.editStrain.averageRating}\nExperiences: ${widget.editStrain.experiences.length}");
        },
        child: Icon(FontAwesomeIcons.check),
        backgroundColor: userInputActive ? Color(0xFF8BD3A8) : Colors.grey[300],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            //Starting Gradient with Smoke Background
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                stops: [
                  .05,
                  .45,
                ],
                colors: [
                  Color(0xFFDDDDDD),
                  Colors.black87,
                ],
              ),
            ),
            child: Image.network(
              "http://justcole.design/wp-content/uploads/2020/02/Smokey-Background-Side.png", //TODO: update this to an assett image
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              colorBlendMode: BlendMode.overlay,
            ),
          ),
          Theme(
            data: ThemeData(
              primaryColor: Color(0xFF51B579),
            ),
            child: AnimatedOpacity(
              opacity: 1, //_myOpacity,
              curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
              duration: Duration(seconds: 1),
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 100,),
                        PhraseInputUI( /** STRAIN NAME **/
                            phraseType: PhraseType.Strain,
                            hint: "strain name",
                            initialValues: [widget.editStrain.name],
                            enforceUniqueInput: true,
                            warningText: "*Strain name already exists* Please enter a unique Strain name.",
                            warningTextColor: warningTextColor,
                            callback: (String userInput) {
                              //returns the matching Strain from the PhraseInputUI widget
                              Strain userStrain;
                              userStrain = Strain.getStrainByName(userInput);
                              
                              if (userInput == "") {
                                userStrainName = null;
                              } else {
                                userStrainName = userInput;
                              }

                              //if the userStrain exists already, preset _thcSliderValue, _cbdSliderValue
                              //unless the existing Strain is the current Strain
                              if (userStrain != null && userStrain != widget.editStrain) {
                                setState(() {
                                  this.subspecies = userStrain.subSpecies;
                                  toggleSubSpeciesButtons(subSpecies: this.subspecies);

                                  _thcSliderValue = userStrain.thcPercent;
                                  _cbdSliderValue = userStrain.cbdPercent;

                                  thcPercentController.text = userStrain.thcPercent.toStringAsFixed(1);
                                  cbdPercentController.text = userStrain.cbdPercent.toStringAsFixed(1);

                                  //disable the THC and CBD sliders
                                  setTHC = null;
                                  setCBD = null;

                                  //disable user input
                                  userInputActive = false;

                                  warningTextColor = Colors.white.withOpacity(0.9);
                                });
                              } else {
                                setState(() {
                                  userInputActive = true;

                                  setTHC = (newPercentage) {
                                    setState(() {
                                      _thcSliderValue = newPercentage;
                                      thcPercentController.text =
                                          newPercentage.toStringAsFixed(1);
                                    });
                                  };

                                  setCBD = (newPercentage) {
                                    setState(() {
                                      _cbdSliderValue = newPercentage;
                                      cbdPercentController.text =
                                          newPercentage.toStringAsFixed(1);
                                    });
                                  };
                                });
                              }
                            }),
                        Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 15, 0, 0),
                            child: Text('TYPE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]),
                        Row(
                          /** STRAIN SUBSPECIES **/
                          children: <Widget>[
                            GestureDetector(
                              // Sativa button
                              child: sativaButton,
                              onTap: () {
                                if (userInputActive) {
                                  if (this.subspecies != Sub_species.Sativa) { //selects the tapped Subspecies
                                    this.subspecies = Sub_species.Sativa;
                                    setState(() {
                                      toggleSubSpeciesButtons(subSpecies: this.subspecies);
                                    });
                                  } else { //deselects the tapped Subspecies
                                    this.subspecies = Sub_species.unknown;
                                    setState(() {
                                      toggleSubSpeciesButtons();
                                    });
                                  }
                                }
                              },
                            ),
                            GestureDetector(
                              // Indica button
                              child: indicaButton,
                              onTap: () {
                                if (userInputActive) {
                                  if (this.subspecies != Sub_species.Indica) { //selects the tapped Subspecies
                                    this.subspecies = Sub_species.Indica;
                                    setState(() {
                                      toggleSubSpeciesButtons(subSpecies: this.subspecies);
                                    });
                                  } else { //deselects the tapped Subspecies
                                    this.subspecies = Sub_species.unknown;
                                    setState(() {
                                      toggleSubSpeciesButtons();
                                    });
                                  }
                                }
                              },
                            ),
                            GestureDetector(
                              // Hybrid button
                              child: hybridButton,
                              onTap: () {
                                if (userInputActive) {
                                  if (this.subspecies != Sub_species.Hybrid) { //selects the tapped Subspecies
                                    this.subspecies = Sub_species.Hybrid;
                                    setState(() {
                                      toggleSubSpeciesButtons(subSpecies: this.subspecies);
                                    });
                                  } else { //deselects the tapped Subspecies
                                    this.subspecies = Sub_species.unknown;
                                    setState(() {
                                      toggleSubSpeciesButtons();
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        Row( /** STRAIN THC **/
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                              child: Text('THC %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                ),
                                child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    controller: thcPercentController,
                                    enabled: userInputActive,
                                    enableInteractiveSelection: userInputActive,
                                    keyboardType:
                                        TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (String inputString) {
                                      //Validate the input text as only a double
                                      setState(() {
                                        _thcValidValue = validatePercentInput(
                                            inputString, _thcValidValue);
                                        thcPercentController.text = _thcValidValue;
                                        thcPercentController.selection =
                                            TextSelection.fromPosition(TextPosition(
                                                offset: thcPercentController.text.length));
                                      });
                                    }, // onChanged
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                                      hintText: "%",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white54,
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color(0xFFbfd7c9),
                                  inactiveTrackColor: Color(0xFF3e865d),
                                  trackShape: RectangularSliderTrackShape(),
                                  trackHeight: 3.0,
                                ),
                                child: Slider(
                                  activeColor: Colors.white,
                                  min: 0.0,
                                  max: 100.0,
                                  label: 'THC',
                                  onChanged: setTHC,
                                  value: _thcSliderValue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row( /** STRAIN CBD PERCENTAGE **/
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                              child: Text('CBD %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                    controller: cbdPercentController,
                                    enabled: userInputActive,
                                    enableInteractiveSelection: userInputActive,
                                    keyboardType:
                                        TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (String inputString) {
                                      //Validate the input text as only a double
                                      setState(() {
                                        _cbdValidValue = validatePercentInput(
                                            inputString, _cbdValidValue);
                                        cbdPercentController.text = _cbdValidValue;
                                        cbdPercentController.selection =
                                            TextSelection.fromPosition(TextPosition(
                                                offset: cbdPercentController.text.length));
                                      });
                                    }, // onChanged
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),

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
                                      hintText: "%",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white54,
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color(0xFFbfd7c9),
                                  inactiveTrackColor: Color(0xFF3e865d),
                                  trackShape: RectangularSliderTrackShape(),
                                  trackHeight: 3.0,
                                ), // data
                                child: Slider(
                                  activeColor: Colors.white,
                                  min: 0.0,
                                  max: 100.0,
                                  label: 'CBD',
                                  onChanged: setCBD,
                                  value: _cbdSliderValue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Strain strain) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StrainPage(strain),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0;
      var end = 1;
      var curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}