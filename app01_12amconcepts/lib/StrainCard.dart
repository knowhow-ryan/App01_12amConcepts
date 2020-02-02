import 'package:flutter/material.dart';

class StrainCard extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Strain strain;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  StrainCard(this.strain);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 0, 18, 15),
      child: Container(
        //Sativa Orange Card
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(14.0),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              blurRadius: 2.0,
            ),
          ],
          gradient: LinearGradient(
            end: FractionalOffset.bottomCenter,
            begin: FractionalOffset.topLeft,
            stops: [
              .6,
              1,
            ],
            colors: [//depends on genetics
              Color(0xFFFFFFFF),
              // Color(0xFFedccb3), //Orange
              //   Color(0xFFbfd7c9), //Green
                Color(0xFFceafcc), //Purple
            ],
          ), 
        ),

        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(strain.name,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            )),
                        SizedBox(
                          height: 2,
                        ),
                        Text(strain.location,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text('THC: ${strain.thc}%',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'CBD: ${strain.cbd}%',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black54,
                              size: 18,
                            ),
                            Text(': ${strain.rating}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    width: 120,
                    height: 95,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14.0),
                              bottomRight: Radius.circular(14.0),
                              bottomLeft: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                            ),
                            color: Colors.green,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/1466335/pexels-photo-1466335.jpeg"),
                            ))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//This is a dummy strain so you have data you can insert into the UI
//you access this information by using strain.name, strain.thc, etc.
class Strain {
  String name;
  double thc;
  double cbd;
  double rating;
  String date;
  String location;
  String genetics;

  Strain() {
    this.name = "Jedi Killer Kush";
    this.thc = 18.5;
    this.cbd = 2.3;
    this.rating = 4.7;
    this.date = "04/20/20";
    this.location = "Destroyer's Burger Cave";
    this.genetics = "Sativa";
  }
}
