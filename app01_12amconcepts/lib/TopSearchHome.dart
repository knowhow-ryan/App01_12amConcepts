import 'package:flutter/material.dart';
import 'CreditsPage.dart';
import 'StrainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';

class TopSearchHome extends StatefulWidget {
  TextEditingController searchController;
  SortBy sortStrainsBy;
  IconData sortIcon;
  Function sortToggle;

  TopSearchHome({this.searchController, this.sortStrainsBy, this.sortToggle}) {
    if (sortStrainsBy == SortBy.Alphabetical) {
      sortIcon = FontAwesomeIcons.sortAlphaDown;
    } else if (sortStrainsBy == SortBy.Date) {
      sortIcon = FontAwesomeIcons.calendarAlt;
    }
  }

  @override
  TopSearchHomeState createState() => TopSearchHomeState();
}

class TopSearchHomeState extends State<TopSearchHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 45, 8, 10),
      child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.listAlt,
                    color: Colors.white,
                  ),
                  iconSize: 28,
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.of(context).push(_createRoute()); //telling button what to do
                  },
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                  ),
                  child: TextField(
                      controller: widget.searchController,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
                        suffixIcon: Icon(Icons.search),
                        hintText: "Highly Rated",
                        hintStyle: TextStyle(
                          fontSize: 19,
                          color: Colors.white54,
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    widget.sortIcon,
                    color: Colors.white,
                  ),
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () => widget.sortToggle(),
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

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)); //what does this do?

      return FadeTransition(
        // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}
