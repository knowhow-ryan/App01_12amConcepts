/*
import 'package:flutter/material.dart';
import 'StrainCard.dart';
import 'TopSearch.dart';
import 'ExperienceCard.dart';
import 'Strain.dart';

class StrainPage extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Strain strain;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  StrainPage(this.strain);

  @override
  Widget build(BuildContext context) {
    Experience experience = new Experience();
    return Container(//Background Gradient
      decoration: BoxDecoration(
        gradient: LinearGradient(//Strain Page Gradients
          end: FractionalOffset.topCenter,
          begin: FractionalOffset.bottomCenter,
          stops: [.6, .9,],
          // colors: [
          //   Color(0xFFDDDDDD),
          //   Color(0xFFEDB78E),//Sativa BACKGROUND orange
          // ], //Sativa Orange BACKGROUND gradient
          colors: [
            Color(0xFFDDDDDD),
            Color(0xFF8BD3A8),//Hybrid BACKGROUND green
          ], //Hybrid Green BACKGROUND gradient
          // colors: [
          //   Color(0xFFDDDDDD),
          //   Color(0xFFCE96CA),//Indica BACKGROUND purple
          // ], //Indica Purple BACKGROUND gradient

        ), 
      ),
     
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopSearch(),
            Container(//Strain Picture Box
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.pexels.com/photos/1466335/pexels-photo-1466335.jpeg"),
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black38,
                    blurRadius: 8.0,
                  ),
                ],
                
              ),

              child: Stack(
                children: <Widget>[
                  Positioned(//Genetic Callout Blurb
                    height: 45,
                    width: 85,
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Center(
                            child: Text(strain.genetics,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                )),
                          )),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
                          ))),
                ],
              ),
            ),
            
            Text(strain.name,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                )),
            SizedBox(
              height: 3,
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
                  size: 15,
                ),
                Text(': ${strain.rating}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ],
            ),
            Row(//Divider
              children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.black45,
                ))
              ],
            ),
            Column(//Experiences Title
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text("Experiences",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  Expanded(
              child: ListView(
                children: <Widget>[
                  ExperienceCard(experience),
                  ExperienceCard(experience),
                  ExperienceCard(experience)
                
                ],
              ),
            ),
                
              ],
            ),
          
          ],
        
        ),
        
      ),
    );
  }
}
*/