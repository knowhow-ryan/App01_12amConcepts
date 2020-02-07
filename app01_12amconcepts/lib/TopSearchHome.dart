import 'package:flutter/material.dart';
import 'CreditsPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TopSearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 45, 12, 15),
      child: Container(
        height:50,
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.listAlt, color: Colors.white,),
              iconSize: 30,
              color: Colors.white60,
              onPressed: () {
                Navigator.of(context).push(_createRoute());//telling button what to do
              },
            ),
          ),
          Expanded(
           flex:6,
            child: Container(
              decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
              child: TextField(
               
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  suffixIcon: Icon(Icons.search) ,
                    hintText: "Highly Rated",
                    hintStyle: TextStyle(fontSize: 17),
                )
              ),
            ),
          ),
          Expanded(
            flex:1,
            child:
            IconButton(
              icon: Icon(FontAwesomeIcons.sortAlphaDown, color: Colors.white,),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
            
            
          },
            ),
          )
        ],
      )),
    );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CreditsPage(),
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