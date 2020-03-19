import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'StrainPageNoPicture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'Phrase.dart';
import 'SubspeciesPickerButton.dart';
import 'Experience.dart';

class NewExperiencePage extends StatefulWidget {
  NewExperiencePage() : super();

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

class NewExperiencePageState extends State<NewExperiencePage> {
  int currentStep = 0;
  double _thcSliderValue = 0.0;
  double _cbdSliderValue = 0.0;
  double _ratingSliderValue = 1;
  Strain userStrain;
  String userStrainName;
  Sub_species subspecies = Sub_species.unknown;
  bool userInputActive = true;
  String _thcValidValue =
      "0.0"; //the most recent valid value for the THC percentage TextField
  String _cbdValidValue =
      "0.0"; //the most recent valid value for the CBD percentage TextField
  String _ratingValidValue =
      "1"; //the most recent valid value for the Overall Rating TextField

  String userLocation = "";
  String userIngestion = "";

  Widget sativaButton;
  Widget indicaButton;
  Widget hybridButton;

  Function setTHC;
  Function setCBD;
  Function setRating;

  TextEditingController thcPercentController = new TextEditingController();
  TextEditingController cbdPercentController = new TextEditingController();
  TextEditingController ratingController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  List<Phrase> userHighs;
  List<Phrase> userLows;

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

    setRating = (newRating) {
      if (newRating == null) {
        newRating = 1;
      }
      setState(() {
        _ratingSliderValue = newRating;
        if (newRating == 0.0) {
          ratingController.text = "";
        } else {
          ratingController.text = newRating.toStringAsFixed(0);
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

    ratingController.addListener(() {
      if (double.tryParse(ratingController.text) == null) {
        ratingController.text = "";
        setState(() => _ratingSliderValue = 1);
      } else {
        setState(
            () => _ratingSliderValue = double.tryParse(ratingController.text));
      }
    });

    toggleSubSpeciesButtons(); //set all of the Sub_species buttons to deselected

    userHighs = [];
    userLows = [];

    //DEBUG TODO: remove dummy Strains and Experience
    Strain dummyHybrid = Strain.getDummyHybrid;
    Strain dummyIndica = Strain.getDummyIndica;
    Strain dummySativa = Strain.getDummySativa;
    Experience dummyExperience = Experience.dummyExperience;
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

  String validateRatingInput(inputString, validString) {
    /*validate that the inputString represents a double value between 0 and 100, inclusive.
    If the value is invalid, return the input validString*/
    double inputDouble = double.tryParse(inputString);

    if (inputString == "") {
      validString = inputString;
    } else if (inputDouble != null) {
      if (inputDouble >= 1.0 && inputDouble <= 5.0) {
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
    List<Step> steps = [
      Step(
        // Step 1: Strain info
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
                phraseType: PhraseType.Strain,
                hint: "strain name",
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

                      thcPercentController.text =
                          userStrain.thcPercent.toStringAsFixed(1);
                      cbdPercentController.text =
                          userStrain.cbdPercent.toStringAsFixed(1);

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
              // Subspecies picker
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
            Row(
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
        isActive: true,
      ),
      Step(
        // Step 2: Location
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
              callback: (String userInput) => userLocation = userInput,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      Step(
        // Step 3: Ingestion method
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
              callback: (String userInput) => userIngestion = userInput,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      Step(
        // Step 4: Experience
        title: Text('Experience',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            )),
        content: Column(
          children: <Widget>[
            PhraseInputUI(
              phraseType: PhraseType.High,
              hint: 'highs',
              multipleSelection: true,
              callback: (String high) {
                setState(() {
                  //TODO: define highs callback
                  userHighs.add(Phrase.save(high, PhraseType.High));
                });
              }, // call back // setState
            ),
            PhraseInputUI(
              phraseType: PhraseType.Low,
              hint: 'lows',
              multipleSelection: true,
              callback: (String low) {
                setState(() {
                  //TODO: define highs callback
                  userLows.add(Phrase.save(low, PhraseType.Low));
                });
              }, // call back // setState
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
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: ratingController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        onChanged: (String inputString) {
                          //Validate the input text as only a double
                          setState(() {
                            _ratingValidValue = validateRatingInput(
                                inputString, _ratingValidValue);
                            ratingController.text = _ratingValidValue;
                            ratingController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: ratingController.text.length));
                          });
                        },
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
                          hintText: "-",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(0xFFbfd7c9),
                      inactiveTrackColor: Color(0xFF3e865d),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 3.0,
                    ), // data
                    child: Slider(
                      activeColor: Colors.white,
                      min: 1.0,
                      max: 5.0,
                      divisions: 4,
                      label: 'rating',
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
        // Step 5: Notes
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
            //Navigator.of(context).push(_createRoute());//telling button what to do

            //TODO: remove the debug code below
            //DEBUG: print the Strain and Experience information to the console from the generated Strain and Experience objects
            print(
                "***DEBUG***\nStrain: ${userStrain.name.phraseString}\nSubspecies: ${userStrain.subSpecies.toString()}\nTHC: ${userStrain.thcPercent}\tCBD: ${userStrain.cbdPercent}\nAverage Rating: ${userStrain.averageRating}\nExperiences: ${userStrain.experiences.length}");
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
              child: Stepper(
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
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
                        userStrain = new Strain(
                            userStrainName, _thcSliderValue, _cbdSliderValue,
                            subSpecies:
                                subspecies); //TODO: pass subSpecies type when UI implemented
                      }
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
                        userStrain = new Strain(
                            userStrainName, _thcSliderValue, _cbdSliderValue,
                            subSpecies:
                                subspecies); //TODO: pass subSpecies type when UI implemented
                      }
                    }

                    if (currentStep < steps.length - 1 &&
                        userStrainName != null) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StrainPage(Strain.getDummyHybrid),
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
