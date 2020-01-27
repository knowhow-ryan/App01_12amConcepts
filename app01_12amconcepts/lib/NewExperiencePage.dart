import 'package:flutter/material.dart';
import 'StrainPage.dart';


class NewExperiencePage extends StatefulWidget {
  NewExperiencePage() : super();

 

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

// class MyStyle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Color(0xFFb2d3bf),
//         accentColor: Colors.white,
        
//         textTheme: TextTheme(
          
//           headline: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           title: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
//           body1: TextStyle(fontSize: 18,),
//           body2: TextStyle(fontSize: 15),
//         )

//       )
      
//     );
//   }}

// class MyStyle {
//   static TextStyle mytitle(BuildContext context) {
//     return Theme.of(context).textTheme.title.copyWith(fontSize: 20);
//   }
// }

class NewExperiencePageState extends State<NewExperiencePage> {
  //
  int currentStep = 0;
  List<Step> steps = [
    Step(
      title: Text('What Strain?',
      // style: MyStyle.mytitle(context),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontStyle: FontStyle.italic,
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
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Where at?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
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
                          child: Text("home",
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
                              child: Text("apartment",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
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
        fontSize: 18,
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
                              child: Text("pipe",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  )),
                            ),
                          )),
                    ),
              ],
            ),
        ],
      ),
      state: StepState.complete,
      isActive: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
            child: Image.network("http://justcole.design/wp-content/uploads/2020/01/Smokey-Background.png",
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
              currentStep: this.currentStep,
              steps: steps,
              type: StepperType.vertical,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
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
        ],
      ),
    );
  }
}

