
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        stops: [.05, .45,],
                        colors: [Color(0xFFDDDDDD), Colors.black38,],
                      ),
                      ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
              
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  'Credits',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Icon(
                            FontAwesomeIcons.artstation,
                            color: Colors.black26,
                            size: 24,
                          ),
            ],
          ),
          Text(
                'Coding and Design By:',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Text(
                'Ryan Brockey & Cole Petroccione',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                )),
                Text(
                'Please send feedback and questions to:\n\hello@justcole.design',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                )),
                SizedBox(height:20),
                Text(
                'A 12am Concepts App',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Text(
                'check out the 12am Podcast and Blog posts to learn more.\n\anchor.fm/12am-concepts',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                )),
                SizedBox(height:20),
      
          
      ]),
        ),
    );
  }
}

