import 'package:flutter/material.dart';
import 'StrainPage.dart';
import 'StrainCard.dart';
import 'NewExperiencePage.dart';
import 'TopSearch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'ExperienceInputStep2.dart';

class MainPage extends StatelessWidget {
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
    
      body:  Stack(
        children: <Widget>[
          Container( //Starting Gradient with Smoke Background
                      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        stops: [.3, 1,],
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          TopSearch(),
                          StrainCard(new Strain()),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
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
