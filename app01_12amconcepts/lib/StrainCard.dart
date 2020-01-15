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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 115.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 50.0,
              child: Container(
                width: 290.0,
                height: 115.0,
                child: Card(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 64.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(strain.name,
                            style: Theme.of(context).textTheme.headline),
                        Text(strain.location,
                            style: Theme.of(context).textTheme.subhead),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                            ),
                            Text(': ${strain.rating}')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 7.5, child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("http://justcole.design/wp-content/uploads/2019/12/weed@0.25x.png"),
                  ),
                ),
              )
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

  Strain() {
    this.name = "Jedi Killer Kush";
    this.thc = 18.5;
    this.cbd = 2.3;
    this.rating = 4.7;
    this.date = "04/20/20";
    this.location = "Destroyer's Burger Cave";
  }
}