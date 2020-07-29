import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'StrainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'Phrase.dart';
import 'SubspeciesPickerButton.dart';
import 'Experience.dart';
import 'DataControl.dart';

class NewExperiencePage extends StatefulWidget {
  final Experience editExperience;

  NewExperiencePage({this.editExperience}) : super();
  //if an Experience is included, then NewExperiencePage opens in editMode

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

class NewExperiencePageState extends State<NewExperiencePage> {
  bool editMode = false; //editMode is enabled if NewExperiencePage was called with in input Experience parameter
  /*When editMode is true, then all of the information in the Stepper will be prefilled with the values from the input Experience
  **When the user presses the submit FAB, a new Experience will not be created, but rather, the information will saved to the input Experience*/

  bool userInputActive = true;

  Strain userStrain;
  Experience userExperience;

  int currentStep = 0;
  double _thcSliderValue = 0.0;
  double _cbdSliderValue = 0.0;
  double _ratingSliderValue = 0;
  String userStrainName;
  Sub_species subspecies = Sub_species.unknown;
  String _thcValidValue = "0.0"; //the most recent valid value for the THC percentage TextField
  String _cbdValidValue = "0.0"; //the most recent valid value for the CBD percentage TextField

  String userLocation = "";
  String userIngestion = "";

  Widget sativaButton;
  Widget indicaButton;
  Widget hybridButton;

  Function setTHC;
  Function setCBD;
  Function setRating;

  TextEditingController strainNameController = new TextEditingController();
  TextEditingController thcPercentController = new TextEditingController();
  TextEditingController cbdPercentController = new TextEditingController();
  TextEditingController highsController = new TextEditingController();
  TextEditingController lowsController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  List<Phrase> userHighs;
  List<Phrase> userLows;

  @override
  void initState() {
    super.initState();

    if (widget.editExperience != null) {
      //if the NewExperiencePage was called with an input Experience, enable Edit Mode
      //Edit Mode is initialized at the bottom of this initState function
      userExperience = widget.editExperience;
      editMode = true; //
    }

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

    setRating = (newRating) {
      if (newRating == null) {
        newRating = 0;
      }
      setState(() {
        _ratingSliderValue = newRating;
        /*if (newRating == 0.0) {
          ratingController.text = "";
        } else {
          ratingController.text = newRating.toStringAsFixed(0);
        }*/
      });
    };

    thcPercentController.addListener(() {
      if (double.tryParse(thcPercentController.text) == null) {
        thcPercentController.text = "";
        setState(() => _thcSliderValue = 0.0);
      } else {
        setState(() => _thcSliderValue = double.tryParse(thcPercentController.text));
      }

      //this keeps the cursor at the end (far right) of the user's input.
      if (thcPercentController.text.length > 0) {
        thcPercentController.selection = TextSelection.fromPosition(TextPosition(offset: thcPercentController.text.length));
      }
    });

    cbdPercentController.addListener(() {
      if (double.tryParse(cbdPercentController.text) == null) {
        cbdPercentController.text = "";
        setState(() => _cbdSliderValue = 0.0);
      } else {
        setState(() => _cbdSliderValue = double.tryParse(cbdPercentController.text));
      }

      //this keeps the cursor at the end (far right) of the user's input.
      if (cbdPercentController.text.length > 0) {
        cbdPercentController.selection = TextSelection.fromPosition(TextPosition(offset: cbdPercentController.text.length));
      }
    });

    toggleSubSpeciesButtons(); //set all of the Sub_species buttons to deselected

    userHighs = [];
    userLows = [];

    if (editMode) {
      //initialize Edit Mode:
      //initialize all Stepper fields to the values from the input Experience
      //set the initial Step to 1 so the user is put right into Experience information

      userStrain = userExperience.strain;
      userStrainName = userStrain.name.phraseString;
      _thcSliderValue = userStrain.thcPercent;
      thcPercentController.text = _thcSliderValue.toString();
      _thcValidValue = _thcSliderValue.toString();
      _cbdSliderValue = userStrain.cbdPercent;
      cbdPercentController.text = _cbdSliderValue.toString();
      _cbdValidValue = _cbdSliderValue.toString();
      userInputActive = false;

      toggleSubSpeciesButtons(subSpecies: userStrain.subSpecies);

      _ratingSliderValue = (userExperience.overallRating ?? 0).toDouble();
      //_ratingValidValue = _ratingSliderValue.toStringAsFixed(0);
      //ratingController.text = _ratingValidValue;
      userLocation = userExperience.location.phraseString;
      userIngestion = userExperience.ingestion.phraseString;
      userHighs = userExperience.highs ?? [];
      userLows = userExperience.lows ?? [];
      notesController.text = userExperience.notes;

      currentStep = 1;
    }
  }

  void dispose() {
    strainNameController.dispose();
    thcPercentController.dispose();
    cbdPercentController.dispose();
    notesController.dispose();
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

    sativaButton = SubspeciesPickerButton(subspecies: Sub_species.Sativa, selected: false);
    indicaButton = SubspeciesPickerButton(subspecies: Sub_species.Indica, selected: false);
    hybridButton = SubspeciesPickerButton(subspecies: Sub_species.Hybrid, selected: false);

    switch (subSpecies) {
      case Sub_species.Hybrid:
        {
          hybridButton = SubspeciesPickerButton(subspecies: Sub_species.Hybrid, selected: true);
        }
        break;

      case Sub_species.Indica:
        {
          indicaButton = SubspeciesPickerButton(subspecies: Sub_species.Indica, selected: true);
        }
        break;

      case Sub_species.Sativa:
        {
          sativaButton = SubspeciesPickerButton(subspecies: Sub_species.Sativa, selected: true);
        }
        break;

      case Sub_species.unknown:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        /*******************************
        Step 1: STRAIN INFO
        - Strain name
        - Strain subspecies
        - THC percentage
        - CBD percentage
        *******************************/
        title: Text('What Strain?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PhraseInputUI(
                /** STRAIN NAME **/
                phraseType: PhraseType.Strain,
                hint: "strain name",
                initialValues: (editMode && userStrain != null) ? [userStrain.name] : null,
                textEditingController: strainNameController,
                callback: (String userInput) {
                  //returns the matching Strain from the PhraseInputUI widget
                  userStrain = null;
                  userStrain = Strain.getStrainByName(userInput);

                  if (userInput == "") {
                    userStrainName = null;
                  } else {
                    userStrainName = userInput;
                  }

                  //if the userStrain exists already, preset _thcSliderValue, _cbdSliderValue
                  if (userStrain != null) {
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
                    });
                  } else {
                    setState(() {
                      userInputActive = true;

                      this.subspecies = Sub_species.unknown;
                      toggleSubSpeciesButtons();

                      setTHC = (newPercentage) {
                        setState(() {
                          _thcSliderValue = newPercentage;
                          thcPercentController.text = newPercentage.toStringAsFixed(1);
                        });
                      };

                      setCBD = (newPercentage) {
                        setState(() {
                          _cbdSliderValue = newPercentage;
                          cbdPercentController.text = newPercentage.toStringAsFixed(1);
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
                      if (this.subspecies != Sub_species.Sativa) {
                        this.subspecies = Sub_species.Sativa;
                        setState(() {
                          toggleSubSpeciesButtons(subSpecies: this.subspecies);
                        });
                      } else {
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
                      if (this.subspecies != Sub_species.Indica) {
                        this.subspecies = Sub_species.Indica;
                        setState(() {
                          toggleSubSpeciesButtons(subSpecies: this.subspecies);
                        });
                      } else {
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
                      if (this.subspecies != Sub_species.Hybrid) {
                        this.subspecies = Sub_species.Hybrid;
                        setState(() {
                          toggleSubSpeciesButtons(subSpecies: this.subspecies);
                        });
                      } else {
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
            Row(
              /** STRAIN THC **/
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
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (String inputString) {
                          //Validate the input text as only a double
                          setState(() {
                            _thcValidValue = validatePercentInput(inputString, _thcValidValue);
                            thcPercentController.text = _thcValidValue;
                          });
                        }, // onChanged
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                      onChanged: userInputActive ? setTHC : null,
                      value: _thcSliderValue,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              /** STRAIN CBD PERCENTAGE **/
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
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (String inputString) {
                          //Validate the input text as only a double
                          setState(() {
                            _cbdValidValue = validatePercentInput(inputString, _cbdValidValue);
                            cbdPercentController.text = _cbdValidValue;
                          });
                        }, // onChanged
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                      onChanged: userInputActive ? setCBD : null,
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
        isActive: true,
      ),
      Step(
        /*******************************
        Step 2: LOCATION
        *******************************/
        title: Text('Where at?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            )),
        isActive: true,
        content: Column(
          children: <Widget>[
            PhraseInputUI(
              phraseType: PhraseType.Location,
              hint: "location",
              initialValues: editMode ? [userExperience.location] : null,
              callback: (String userInput) => userLocation = userInput,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      Step(
        /*******************************
        Step 3: INGESTION METHOD
        *******************************/
        title: Text('How?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            )),
        isActive: true,
        content: Column(
          children: <Widget>[
            PhraseInputUI(
              phraseType: PhraseType.Ingestion,
              hint: "how so",
              initialValues: editMode ? [userExperience.ingestion] : null,
              callback: (String userInput) => userIngestion = userInput,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      Step(
        /*******************************
        Step 4: EXPERIENCE
        - Highs
        - Lows
        - Overall Rating
        *******************************/
        title: Text('Experience',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            )),
        content: Column(
          children: <Widget>[
            PhraseInputUI(
              /** HIGHS **/
              phraseType: PhraseType.High,
              hint: 'highs',
              multipleSelection: true,
              initialValues: editMode ? userHighs : null,
              textEditingController: highsController,
              callback: (high) {
                setState(() {
                  if (high.runtimeType == Phrase) {
                    if (!userHighs.contains(high)) {
                      userHighs.add(high);
                    }
                  } else if (high.runtimeType == String) {
                    Phrase highPhrase = Phrase.save(high, PhraseType.High);
                    if (!userHighs.contains(highPhrase)) {
                      userHighs.add(highPhrase);
                    }
                  }
                });
              }, // callback // setState
              deleteCallback: (removeHigh) {
                setState(() => userHighs.remove(removeHigh));
              }, // deleteCallback
            ),
            PhraseInputUI(
              /** LOWS **/
              phraseType: PhraseType.Low,
              hint: 'lows',
              multipleSelection: true,
              initialValues: editMode ? userLows : null,
              textEditingController: lowsController,
              callback: (low) {
                setState(() {
                  if (low.runtimeType == Phrase) {
                    if (!userLows.contains(low)) {
                      userLows.add(low);
                    }
                  } else if (low.runtimeType == String) {
                    Phrase lowPhrase = Phrase.save(low, PhraseType.Low);
                    if (!userLows.contains(lowPhrase)) {
                      userLows.add(lowPhrase);
                    }
                  }
                });
              }, // call back // setState
              deleteCallback: (removeLow) {
                setState(() => userLows.remove(removeLow));
              }, // deleteCallback
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 0, 8),
                  child: Text('Overall Rating',
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
              /** OVERALL RATING **/
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(0xFFbfd7c9),
                      inactiveTrackColor: Color(0xFF3e865d),
                      showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                      valueIndicatorTextStyle: TextStyle(color: Colors.black),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 3.0,
                    ), // data
                    child: Slider(
                      activeColor: Colors.white,
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: _ratingSliderValue == 0 ? "no rating" : _ratingSliderValue.toInt().toString(),
                      onChanged: setRating,
                      value: _ratingSliderValue, //Do not change
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        isActive: true,
      ),
      Step(
        /*******************************
        Step 5: NOTES
        *******************************/
        title: Text('Notes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            )),
        content: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: notesController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                    hintText: "tell me more",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white54,
                    ),
                  )),
            ),
            SizedBox(height: 20),
          ],
        ),
        isActive: true,
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userStrain != null) {
            //create a new Experience from the user's input
            if (strainNameController.text.isEmpty) {
              strainNameController.text = userStrain.name.phraseString;
            }

            //take any unsubmitted input from the Highs/Lows TextFields and submit it for the user
            if (highsController.text != "") {
              Phrase highPhrase = Phrase.save(highsController.text, PhraseType.High);
              if (!userHighs.contains(highPhrase)) {
                userHighs.add(highPhrase);
              }
            }
            if (lowsController.text != "") {
              Phrase lowPhrase = Phrase.save(lowsController.text, PhraseType.Low);
              if (!userLows.contains(lowPhrase)) {
                userLows.add(lowPhrase);
              }
            }

            if (!editMode) {
              userExperience = new Experience(
                userStrain,
                DateTime.now(),
                Phrase.save(userLocation, PhraseType.Location),
                Phrase.save(userIngestion, PhraseType.Ingestion),
                _ratingSliderValue.toInt(),
                userHighs,
                userLows,
                notesController.text,
              );
            } else {
              //if the Strain was changed, remove the Experience from the old Strain
              userExperience.strain.removeExperience(userExperience);
              //now add it to the Strain it was changed to
              userStrain.addExperience(userExperience);

              userExperience.strain = userStrain;
              userExperience.location = Phrase.save(userLocation, PhraseType.Location);
              userExperience.ingestion = Phrase.save(userIngestion, PhraseType.Ingestion);
              userExperience.overallRating = _ratingSliderValue.toInt();
              userExperience.highs = userHighs;
              userExperience.lows = userLows;
              userExperience.notes = notesController.text;
            }

            DataControl.saveStrains();
            DataControl.saveExperiences();

            Navigator.of(context).push(_createRoute(userStrain)); //call the Route to the Strain page for the userStrain
          }
        },
        child: Icon(FontAwesomeIcons.check),
        backgroundColor: Color(0xFF8BD3A8),
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
            child: Image(
              image: AssetImage('graphics/Smokey-Background-Side.png'),
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
              child: Stepper(
                controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: onStepContinue,
                          child: Icon(
                            FontAwesomeIcons.arrowAltCircleDown,
                            color: Color(0xFF51B579),
                          ),
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: onStepCancel,
                          child: Icon(
                            FontAwesomeIcons.arrowAltCircleUp,
                            color: Color(0xFF51B579),
                          ),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  );
                },
                currentStep: this.currentStep,
                steps: steps,
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    //when the user advances past the first step, save the Strain
                    if (currentStep == 0 && step != 0) {
                      if (userStrain == null && userStrainName != null) {
                        userStrain = new Strain(userStrainName, _thcSliderValue, _cbdSliderValue, subSpecies: subspecies);
                      }
                    } else if (currentStep != 0 && step == 0) {
                      //this is a fix for the Strain name TextField resetting when the user interacts with the Highs/Lows TextFields
                      strainNameController.text = userStrain?.name?.phraseString;
                    }

                    if (userStrainName != null) {
                      currentStep = step;
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    //when the user advances past the first step, save the Strain
                    if (currentStep == 0) {
                      if (userStrain == null && userStrainName != null) {
                        userStrain = new Strain(userStrainName, _thcSliderValue, _cbdSliderValue, subSpecies: subspecies);
                      }
                    } else if (currentStep == steps.length - 1) {
                      //this is a fix for the Strain name TextField resetting when the user interacts with the Highs/Lows TextFields
                      strainNameController.text = userStrain?.name?.phraseString;
                    }

                    if (currentStep < steps.length - 1 && userStrainName != null) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      strainNameController.text = userStrain?.name
                          ?.phraseString; //this is a fix for the Strain name TextField resetting when the user interacts with the Highs/Lows TextFields

                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
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
    pageBuilder: (context, animation, secondaryAnimation) => StrainPage(strain),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}
