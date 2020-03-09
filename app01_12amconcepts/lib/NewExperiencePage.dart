import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'StrainPageNoPicture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'Phrase.dart';
import 'SubspeciesPickerButton.dart';
//import 'Experience.dart';


class NewExperiencePage extends StatefulWidget {
  NewExperiencePage() : super();

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

class NewExperiencePageState extends State<NewExperiencePage> {
  int currentStep = 0;
  double _thcSliderValue = 0.0;
  double _cbdSliderValue = 0.0;
  double _ratingSliderValue = 0.0;
  Strain userStrain;
  String userStrainName;
  Sub_species subspecies = Sub_species.unknown;
  bool userInputActive = true;
  String _thcValidValue ="0.0"; //the most recent valid value for the THC percentage TextField
  String _cbdValidValue = "0.0"; //the most recent valid value for the CBD percentage TextField

  Widget sativaButton;
  Widget indicaButton;
  Widget hybridButton;

  Function setTHC;
  Function setCBD;

  TextEditingController thcPercentController = new TextEditingController();
  TextEditingController cbdPercentController = new TextEditingController();

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
        }
        else {
          thcPercentController.text = newPercentage.toStringAsFixed(2);
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
        }
        else {
          cbdPercentController.text = newPercentage.toStringAsFixed(2);
        }
      });
    };

    thcPercentController.addListener(() {
      if (double.tryParse(thcPercentController.text) == null) {
        thcPercentController.text = "";
        setState(() => _thcSliderValue = 0.0);
      }
      else {
        setState(() => _thcSliderValue = double.tryParse(thcPercentController.text));
      }
    });

    cbdPercentController.addListener(() {
      if (double.tryParse(cbdPercentController.text) == null) {
        cbdPercentController.text = "";
        setState(() => _cbdSliderValue = 0.0);
      }
      else {
        setState(() => _cbdSliderValue = double.tryParse(cbdPercentController.text));
      }
    });

    toggleSubSpeciesButtons(); //set all of the Sub_species buttons to deselected

    //DEBUG TODO: remove dummy Strains
    Strain dummyHybrid = Strain.getDummyHybrid;
    Strain dummyIndica = Strain.getDummyIndica;
    Strain dummySativa = Strain.getDummySativa;
  }

  String validatePercentInput(inputString, validString) {
    /*validate that the inputString represents a double value between 0 and 100, inclusive.
    If the value is invalid, return the input validString*/
    double inputDouble = double.tryParse(inputString);

    if (inputString == "") {
      validString = inputString;
    }
    else if( inputDouble != null) {
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

    switch(subSpecies) {
      case Sub_species.Hybrid: {
        hybridButton = SubspeciesPickerButton(subspecies: Sub_species.Hybrid, selected: true);
      }
      break;

      case Sub_species.Indica: {
        indicaButton = SubspeciesPickerButton(subspecies: Sub_species.Indica, selected: true);
      }
      break;
      
      case Sub_species.Sativa: {
        sativaButton = SubspeciesPickerButton(subspecies: Sub_species.Sativa, selected: true);
      }
      break;

      case Sub_species.unknown:
      break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Step> steps = [Step(
      title: Text('What Strain?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        )
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PhraseInputUI(
            phraseType: PhraseType.Strain,
            hint: "strain name",
            callback: (String userInput) {//returns the matching Strain from the PhraseInputUI widget
              userStrain = Strain.getStrainByName(userInput);
              userStrainName = userInput;

              //if the userStrain exists already, preset _thcSliderValue, _cbdSliderValue
              if(userStrain != null) {
                setState(() {
                  this.subspecies = userStrain.subSpecies;
                  toggleSubSpeciesButtons(subSpecies: this.subspecies);

                  _thcSliderValue = userStrain.thcPercent;
                  _cbdSliderValue = userStrain.cbdPercent;

                  thcPercentController.text = userStrain.thcPercent.toStringAsFixed(2);
                  cbdPercentController.text = userStrain.cbdPercent.toStringAsFixed(2);

                  //disable the THC and CBD sliders
                  setTHC = null;
                  setCBD = null;

                  //disable user input
                  userInputActive = false;
                });
              }
              else {
                setState(() {
                  userInputActive = true;

                  this.subspecies = Sub_species.unknown;
                  toggleSubSpeciesButtons();

                  setTHC = (newPercentage) {
                    setState(() { 
                      _thcSliderValue = newPercentage;
                      thcPercentController.text = newPercentage.toStringAsFixed(2);
                    });
                  };

                  setCBD = (newPercentage) {
                    setState(() {
                      _cbdSliderValue = newPercentage;
                      cbdPercentController.text = newPercentage.toStringAsFixed(2);
                    });
                  };
                });
              }
            }
          ),
          Row( // Subspecies picker
            children: <Widget>[
              GestureDetector( // Sativa button
                child: sativaButton,
                onTap: () {
                  if(userInputActive) {
                    if(this.subspecies != Sub_species.Sativa) {
                      this.subspecies = Sub_species.Sativa;
                      setState(() {
                        toggleSubSpeciesButtons(subSpecies: this.subspecies);
                      });
                    }
                    else {
                      this.subspecies = Sub_species.unknown;
                      setState(() {
                        toggleSubSpeciesButtons();
                      });
                    }
                  }
                },
              ),
              GestureDetector( // Indica button
                child: indicaButton,
                onTap: () {
                  if(userInputActive) {
                    if(this.subspecies != Sub_species.Indica) {
                      this.subspecies = Sub_species.Indica;
                      setState(() {
                        toggleSubSpeciesButtons(subSpecies: this.subspecies);
                      });
                    }
                    else {
                      this.subspecies = Sub_species.unknown;
                      setState(() {
                        toggleSubSpeciesButtons();
                      });
                    }
                  }
                },
              ),
              GestureDetector( // Hybrid button
                child: hybridButton,
                onTap: () {
                  if(userInputActive) {
                    if(this.subspecies != Sub_species.Hybrid) {
                      this.subspecies = Sub_species.Hybrid;
                      setState(() {
                        toggleSubSpeciesButtons(subSpecies: this.subspecies);
                      });
                    }
                    else {
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
                child: Text('THC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex:1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TextField(

                    controller: thcPercentController,
                    enabled: userInputActive,
                    enableInteractiveSelection: userInputActive,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (String inputString) { //Validate the input text as only a double
                      setState(() {
                        _thcValidValue = validatePercentInput(inputString, _thcValidValue);
                        thcPercentController.text = _thcValidValue;
                        thcPercentController.selection = TextSelection.fromPosition(TextPosition(offset: thcPercentController.text.length));
                      });
                    }, // onChanged
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "00%",
                        hintStyle: TextStyle(fontSize: 15),
                    )
                  ),
                ),
              ),
              Expanded(
                flex:4,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Color(0xFFbfd7c9),
                    inactiveTrackColor: Color(0xFF3e865d),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 3.0,
                  ),
                  child: Slider(
                    activeColor:  Colors.white, 
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
                child: Text('CBD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex:1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TextField(
                    controller: cbdPercentController,
                    enabled: userInputActive,
                    enableInteractiveSelection: userInputActive,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (String inputString) { //Validate the input text as only a double
                      setState(() {
                        _cbdValidValue = validatePercentInput(inputString, _cbdValidValue);
                        cbdPercentController.text = _cbdValidValue;
                        cbdPercentController.selection = TextSelection.fromPosition(TextPosition(offset: cbdPercentController.text.length));
                      });
                    }, // onChanged
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: "00%",
                      hintStyle: TextStyle(fontSize: 15),
                    )
                  ),
                ),
              ),
              Expanded(
                flex:4,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Color(0xFFbfd7c9),
                    inactiveTrackColor: Color(0xFF3e865d),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 3.0,
                  ), // data
                  child: Slider(
                    activeColor:  Colors.white,       
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
          SizedBox(height:20,)
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Where at?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      )
      ),
      isActive: true,
      content: Column(
        children: <Widget>[
          PhraseInputUI(
            phraseType: PhraseType.Location,
            
          ),
          SizedBox(height:20),
        ],
      ),
    ),
    
    Step(
      title: Text('How?',
       style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      )),
      content: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            child: TextField(
             
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                
                  hintText: "how so",
                  hintStyle: TextStyle(fontSize: 15),
              )
            ),
          ),
          Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(50),
                        color: Colors.white70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,8,12,8),
                        child: Center(
                          child: Text("bong",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              )),
                        ),
                      )),
                ),
                Padding(
                      padding: const EdgeInsets.only(left:4,right:4,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("pipe",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
            SizedBox(height:20),
        ],
      ),
      
      isActive: true,
    ),

    Step(
      title: Text('Experience',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      )
      ),
      content: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            child: TextField(
             
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                
                  hintText: "highs",
                  hintStyle: TextStyle(fontSize: 15),
              )
            ),
          ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(50),
                        color: Colors.white70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,8,12,8),
                        child: Center(
                          child: Text("stoney",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              )),
                        ),
                      )),
                ),
                Padding(
                      padding: const EdgeInsets.only(left:4,right:4,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("relaxed",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
           SizedBox(height:20),
            Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            child: TextField(
             
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                
                  hintText: "lows",
                  hintStyle: TextStyle(fontSize: 15),
              )
            ),
          ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(50),
                        color: Colors.white70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,8,12,8),
                        child: Center(
                          child: Text("couchlocked",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              )),
                        ),
                      )),
                ),
                Padding(
                      padding: const EdgeInsets.only(left:4,right:4,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("anxious",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
            
             Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                child: Text('Overall Rating',
      
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      )
      ),
              ),
            ],
          ),
            Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Container(
                    decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
                    child: TextField(
                      decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    
                      hintText: "-",
                      hintStyle: TextStyle(fontSize: 15),
              )

                    ),
                  ),
                ),
                Expanded(
                  flex:4,
                  child: SliderTheme(
                     data: SliderTheme.of(context).copyWith(
        activeTrackColor: Color(0xFFbfd7c9),
        inactiveTrackColor: Color(0xFF3e865d),
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 3.0,
                     ),
                    child: Slider(
                          activeColor:  Colors.white, 
                          
                          min: 0.0,
                          max: 5.0,
                          label: 'rating',
                          onChanged: (newPercentage) {//Do not change
                            setState(() => _ratingSliderValue = newPercentage);//do not change
                          },
                          value: _ratingSliderValue,//Do not change
                        ),
                  ),
                ),
              ],
            ),
SizedBox(height:20),
        ],
      ),
      isActive: true,
    
    ),
    
    Step(
      title: Text('Notes',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      )
      ),
      content: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            child: TextField(
             
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                
                  hintText: "tell me more",
                  hintStyle: TextStyle(fontSize: 15),
              )
            ),
          ),
           
SizedBox(height:20),
        ],
      ),
      isActive: true,
    
    ),
  ];

    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
      onPressed: () {
            Navigator.of(context).push(_createRoute());//telling button what to do
          },
          
      child: Icon(FontAwesomeIcons.check),
      backgroundColor: Color(0xFF8BD3A8),
    ),
      // Body
      body: Stack(
        children: <Widget>[
          Container( //Starting Gradient with Smoke Background
              decoration: BoxDecoration(
              gradient: LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                stops: [.05, .45,],
                colors: [Color(0xFFDDDDDD), Colors.black87,],
              ),
              ),
            child: Image.network("http://justcole.design/wp-content/uploads/2020/02/Smokey-Background-Side.png", //TODO: update this to an assett image
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.overlay,
            ),
            ),
          Theme(
            data: ThemeData(
      primaryColor: Color(0xFF51B579),
      
    ),
            child: AnimatedOpacity(
              
              opacity: 1,//_myOpacity,
              curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
              duration: Duration(seconds:1),
              child: Stepper(
                controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: onStepContinue,
                            child: Icon(FontAwesomeIcons.arrowAltCircleDown, color: Color(0xFF51B579),),
                            color: Colors.black54,
                          ),
                        ),
                        
                        Expanded(
                          child: FlatButton(
                            onPressed: onStepCancel,
                            child: Icon(FontAwesomeIcons.arrowAltCircleUp, color: Color(0xFF51B579),),
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
                      if (userStrain != null) {
                        userStrain = new Strain(userStrainName, _thcSliderValue, _cbdSliderValue, subSpecies: subspecies); //TODO: pass subSpecies type when UI implemented
                      }
                    }

                    currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    //when the user advances past the first step, save the Strain
                    if (currentStep == 0) {
                      if (userStrain != null) {
                        userStrain = new Strain(userStrainName, _thcSliderValue, _cbdSliderValue, subSpecies: subspecies); //TODO: pass subSpecies type when UI implemented
                      }
                    }
                    
                    if (currentStep < steps.length - 1) {
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
    pageBuilder: (context, animation, secondaryAnimation) => StrainPage(Strain.getDummyHybrid),
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