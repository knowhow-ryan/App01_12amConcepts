import 'package:flutter/material.dart';


class NewExperiencePage extends StatefulWidget {
  NewExperiencePage() : super();

 

  @override
  NewExperiencePageState createState() => NewExperiencePageState();
}

class NewExperiencePageState extends State<NewExperiencePage> {
  //
  int currentStep = 0;
  List<Step> steps = [
    Step(
      title: Text('What Strain?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontStyle: FontStyle.italic,
      )),
      content: Text('Hello!'),
      isActive: true,
    ),
    Step(
      title: Text('Where at?'),
      content: Text('World!'),
      isActive: true,
    ),
    Step(
      title: Text('How?'),
      content: Text('Hello World!'),
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
                stops: [.6, .9,],
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
      primaryColor: Color(0xFFb2d3bf),
      secondaryHeaderColor: Colors.white,
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

