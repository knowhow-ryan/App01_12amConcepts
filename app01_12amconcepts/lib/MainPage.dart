import 'package:flutter/material.dart';
import 'StrainPage.dart';
import 'NewExperiencePage.dart';
import 'TopSearchHome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Strain.dart';
import 'dart:async';
import 'StrainEditPage.dart';
import 'DataControl.dart';

class MainPage extends StatefulWidget {
  MainPage() : super();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Future<String> incomingStrainData;
  Future<bool> userDataLoaded;

  //Strain search and sort values
  String searchStrainsFor = "";
  SortBy sortStrainsBy = SortBy.Date;

  TextEditingController searchController = new TextEditingController(); //controller for the search bar

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchStrainsFor = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Widget> getStrainCards() {
    List<Widget> strainCards = [];
    Completer userDeleteReaction = new Completer();

    Strain.filterStrains(searchString: searchStrainsFor, sortBy: sortStrainsBy).forEach((strain) {
      strainCards.add(Padding(
        padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
        child: Dismissible(
          key: Key(strain.name.phraseString), //Dismissibles require a unique Key for its child;
          child: InkWell(
            child: strain.displayCard(),
            onTap: () {
              Navigator.of(context).push(_createRoute(destination: StrainPage(strain)));
            }, //telling button where to go next
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            //Remove the Strain's name from the StrainName Phrase List
            strain.name.remove();
            // Remove the item from the data source.
            Strain.allStrains.remove(strain);
            // update the data File
            DataControl.saveStrains();
            DataControl.saveExperiences();
          },

          confirmDismiss: (direction) async {
            userDeleteReaction = new Completer();

            return await userDeleteReaction.future; //return the user's selection from the delete confirmation panel
          },
          background: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: Container(
              // delete confirmation panel
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.redAccent,
                ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                InkWell(
                  // cancel the delete action
                  child: Icon(FontAwesomeIcons.angleDoubleRight,
                  color: Colors.white70,
                  size:20,
                  ),
                  onTap: (() => userDeleteReaction.complete(false)),
                ),
                InkWell(
                    // edit the swiped Strain
                    child: Icon(
                      FontAwesomeIcons.pencilAlt,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onTap: () {
                      userDeleteReaction.complete(false);
                      Navigator.of(context).push(_createRoute(destination: StrainEditPage(strain)));
                    }),
                InkWell(
                  // confirm the delete action
                  child: Icon(FontAwesomeIcons.trashAlt,
                  color: Colors.white70,
                  size: 20,
                  ),
                  onTap: (() => userDeleteReaction.complete(true)),
                )
              ]),
            ),
          ),
        ),
      ));
    });

    return strainCards;
  }

  @override
  Widget build(BuildContext context) {
    //incomingStrainData = DataControl.loadStrains();
    userDataLoaded = DataControl.loadAll();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute(destination: NewExperiencePage())); //telling button what to do
        },
        child: Icon(FontAwesomeIcons.bong),
        backgroundColor: Color(0xFF3e865d),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            //Starting Gradient with Smoke Background
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                stops: [
                  .05,
                  .45,
                ],
                colors: [
                  Color(0xFFDDDDDD),
                  Colors.black87,
                ],
              ),
            ),
            child: Image(
              image: AssetImage('graphics/Smokey-Background-Side.png'),
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
                child: TopSearchHome(
                    searchController: searchController,
                    sortStrainsBy: sortStrainsBy,
                    sortToggle: () {
                      setState(() {
                        if (sortStrainsBy == SortBy.Alphabetical) {
                          sortStrainsBy = SortBy.Date;
                        } else if (sortStrainsBy == SortBy.Date) {
                          sortStrainsBy = SortBy.Alphabetical;
                        }
                      });
                    }),
              ),
              Expanded(
                child: FutureBuilder<bool>(
                  //builds the primary page content only once the user data is loaded
                  future: userDataLoaded,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    Widget underConstruction;

                    //this is the main decision-making routine for loading data.
                    //Conditionally loads either the user data, an error message, or a loading indicator
                    if (snapshot.hasData) {
                      //only triggers if both the Strain and Experience Futures have completed
                      //Strain.reload(snapshot.data);
                      underConstruction = ListView(
                        padding: EdgeInsets.only(top: 0.0),
                        shrinkWrap: true,
                        children: getStrainCards(),
                      );
                    } else if (snapshot.hasError) {
                      print("***MainPage builder error***\n\n" + snapshot.error.toString());

                      if (snapshot.error.toString().contains("OS Error: No such file or directory")) {
                        underConstruction = Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('no data',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              )),
                        ));
                      } else {
                        underConstruction = Center(
                            child: Icon(
                          Icons.error_outline,
                          color: Colors.red[200],
                          size: 60,
                        ));
                      }
                    } else {
                      underConstruction = Column(
                        children: [
                          Center(
                              child: SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          )),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('rolling a blunt...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                )),
                          ))
                        ],
                      );
                    }

                    return underConstruction;
                  },
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
