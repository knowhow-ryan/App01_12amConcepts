import 'package:app01_12amconcepts/Strain.dart';
import 'package:flutter/material.dart';
// import 'StrainPage.dart';
import 'NewExperiencePage.dart';
import 'TopSearchHome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
// import 'ExperienceInputStep2.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
    
    return Scaffold(
     floatingActionButton: FloatingActionButton(
      onPressed: () {
            Navigator.of(context).push(_createRoute());//telling button what to do
            
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
                  children: <Widget>[
                    Strain.getDummyHybrid.displayCard(),
                    Strain.getDummyIndica.displayCard(),
                    Strain.getDummySativa.displayCard(),
                    Strain.getDummyIndica.displayCard(),
                    Strain.getDummyHybrid.displayCard(),
                    Strain.getDummySativa.displayCard()
                  ],
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
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
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