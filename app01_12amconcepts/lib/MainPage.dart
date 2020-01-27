import 'package:flutter/material.dart';
import 'StrainPage.dart';
import 'StrainCard.dart';
import 'NewExperiencePage.dart';
// import 'ExperienceInputStep2.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
    
    return Scaffold(
     floatingActionButton: FloatingActionButton(
      onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          
      child: Icon(Icons.done),
      backgroundColor: Color(0xFF8BD3A8),
    ),
    
      body: Container(
        
        child: NewExperiencePage(),
    ));
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
