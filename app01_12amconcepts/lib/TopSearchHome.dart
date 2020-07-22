import 'package:flutter/material.dart';
import 'CreditsPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';

class TopSearchHome extends StatefulWidget {
  final TextEditingController searchController;
  final SortBy sortStrainsBy;
  final Function sortToggle;

  TopSearchHome({this.searchController, this.sortStrainsBy, this.sortToggle});

  @override
  TopSearchHomeState createState() => TopSearchHomeState();
}

class TopSearchHomeState extends State<TopSearchHome> {
  IconData sortIcon;

  @override
  Widget build(BuildContext context) {
    if (widget.sortStrainsBy == SortBy.Alphabetical) {
      sortIcon = FontAwesomeIcons.sortAlphaDown;
    } else if (widget.sortStrainsBy == SortBy.Date) {
      sortIcon = FontAwesomeIcons.calendarAlt;
    }
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
                    sortIcon,
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
      return FadeTransition(
        // duration: Duration(seconds:1),
        opacity: animation,
        child: child,
      );
    },
  );
}
