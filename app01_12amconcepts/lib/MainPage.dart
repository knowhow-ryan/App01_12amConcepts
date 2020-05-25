import 'package:flutter/material.dart';
import 'StrainPage.dart';
import 'NewExperiencePage.dart';
import 'TopSearchHome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'dart:async';
import 'StrainEditPage.dart';

class MainPage extends StatefulWidget {
  MainPage() : super();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  void initState() {
    super.initState();

    //TODO: remove dummy data below
    //Strain.getDummyHybrid;
    //Strain.getDummyIndica;
    //Strain.getDummySativa;
  }
  
  List<Widget> getStrainCards() {
    List<Widget> strainCards = [];
    Completer userDeleteReaction = new Completer();

    Strain.allStrains.forEach((strain) {
      strainCards.add( Dismissible(
        key: Key(strain.name.phraseString), //Dismissibles require a unique Key for its child; 
        child: InkWell(
          child: strain.displayCard(),
          onTap: () {Navigator.of(context).push(_createRoute(destination: StrainPage(strain)));},//telling button what to do
        ),
        direction: DismissDirection.endToStart,
          onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  Strain.allStrains.remove(strain);
                });
              },
          confirmDismiss: (direction) async {
            userDeleteReaction = new Completer();

            return await userDeleteReaction.future; //return the user's selection from the delete confirmation panel
          },
          background: Container( // delete confirmation panel
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell( // cancel the delete action
                  child: Icon(Icons.cancel),
                  onTap: (() => userDeleteReaction.complete(false)),
                ),
                InkWell( // edit the swiped Strain
                  child: Icon(
                    FontAwesomeIcons.pencilAlt,
                    color: Colors.white70,
                    size: 13,
                  ),
                  onTap: () {
                    userDeleteReaction.complete(false);
                    Navigator.of(context).push(_createRoute(destination: StrainEditPage(strain)));
                  }
                ),
                InkWell( // confirm the delete action
                  child: Icon(Icons.delete_outline),
                  onTap: (() => userDeleteReaction.complete(true)),
                )
              ]
            ),
          ),
        ));
    });
    
    return strainCards;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute(destination: NewExperiencePage()));//telling button what to do
        },
        child: Icon(FontAwesomeIcons.bong),
        backgroundColor: Color(0xFF3e865d),
      ),

      body:  Stack(
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
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TopSearchHome(),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0.0),
                  shrinkWrap: true,
                  children: getStrainCards(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//Original slide transistion route
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

//Fourth Fade Transistion
Route _createRoute({destination}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destination,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0;
      var end = 1;
      var curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)); //what is this for?

      return FadeTransition(
       // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}

//Third Failed Fade Transistion
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       // var begin = Opacity();
//       // var end = opacity(1.0);
//       // var curve = Curves.ease;

//       // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return AnimatedCrossFade(
//         crossFadeState: CrossFadeState.showSecond,
//         duration: Duration(seconds:5),
//         firstChild: MainPage(),
//         secondChild: NewExperiencePage(),
//       );
//     },
//   );
// }


//Second Failed Fade Transition
//https://api.flutter.dev/flutter/widgets/AnimatedOpacity-class.html
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       // var begin = Opacity(opacity: 0);
//       // var end = Opacity(opacity:1);
//       // var curve = Curves.ease;
      

//       //var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return AnimatedOpacity(
//         opacity: _changeOpacity,
//         duration: Duration(seconds: 1),
//         child: child,
        
//       );
//     },
//   );
// }
// class PageFade extends StatefulWidget {
//   @override
//   createState() => PageFadeState();
// }

// class PageFadeState extends State<PageFade> {
//   double opacityLevel = 1.0;

//   void _changeOpacity() {
//     setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
//   }
// }

//Failed Attempt at Fade Transition
//https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
// _createRoute() {
//   return PageRouteBuilder(
// final MainPage;
//   _createRoute()
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               NewExperiencePage,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//                 opacity: animation,
//                 child: child,
//               ),
//         );
// }