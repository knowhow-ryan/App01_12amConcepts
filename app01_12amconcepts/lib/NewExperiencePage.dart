import 'package:flutter/material.dart';
import 'StrainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';


class NewExperiencePage extends StatefulWidget {
  NewExperiencePage() : super();

 

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

class NewExperiencePageState extends State<NewExperiencePage> {
  //
  int currentStep = 0;
  double _sliderValue = 0.0;
  List<Step> steps() {
    return [Step(
      title: Text('What Strain?',
      
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      )
      ),
      content: 
      Column(
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
                
                  hintText: "strain name",
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
                          child: Text("Jedi Killer",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
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
                              child: Text("Hindu Kush",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
            Text('THC',
      
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      )
      ),
            Slider(
                  activeColor:  Color(0xFFbfd7c9), 
                  
                  min: 0.0,
                  max: 100.0,
                  onChanged: (newPercentage) {//Do not change
                    setState(() => _sliderValue = newPercentage);//do not change
                  },
                  value: _sliderValue,//Do not change
                ),
                Text('CBD',
      
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      )
      ),
                 Slider(
                  activeColor:  Color(0xFFbfd7c9), 
                  min: 0.0,
                  max: 100.0,
                  onChanged: (newPercentage) {//Do not change
                    setState(() => _sliderValue = newPercentage);//do not change
                  },
                  value: _sliderValue,//Do not change
                ),
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
                
                  hintText: "Where at?",
                  hintStyle: TextStyle(fontSize: 22),
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
                          child: Text("home",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22,
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
                              child: Text("apartment",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 22,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),

        ],
      ),
      isActive: true,
    
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
                  hintStyle: TextStyle(fontSize: 22),
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
                                fontSize: 22,
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
                                    fontSize: 22,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
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
                
                  hintText: "ups",
                  hintStyle: TextStyle(fontSize: 22),
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
                                fontSize: 22,
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
                                    fontSize: 22,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Container(
               width: 250,
               height: 1.0,
               color: Colors.white70,
             ),
           ),
            Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            child: TextField(
             
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                
                  hintText: "downs",
                  hintStyle: TextStyle(fontSize: 22),
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
                                fontSize: 22,
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
                                    fontSize: 22,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
            Padding(
             padding: const EdgeInsets.all(12.0),
             child: Container(
               width: 250,
               height: 1.0,
               color: Colors.white70,
             ),
           ),

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
                  hintStyle: TextStyle(fontSize: 22),
              )
            ),
          ),
           

        ],
      ),
      isActive: true,
    
    ),
  ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      onPressed: () {
            Navigator.of(context).push(_createRoute());//telling button what to do
          },
          
      child: Icon(FontAwesomeIcons.cannabis),
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
            child: Image.network("http://justcole.design/wp-content/uploads/2020/02/Smokey-Background-Side.png",
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
              steps: steps(),
              type: StepperType.vertical,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (currentStep < steps().length - 1) {
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
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StrainPage(Strain.getDummyHybrid),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
