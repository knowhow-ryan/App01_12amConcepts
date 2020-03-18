import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
    backgroundColor: Colors.transparent,
    body: Stack(
      children: <Widget>[
        Container(
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
                Colors.black38,
              ],
            ),
          ),
          child: Image.network("http://justcole.design/wp-content/uploads/2020/02/Smokey-Background-Side.png",
                      height: double.maxFinite,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.overlay,
                    ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 1, child: Row()),
                  Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom:10,),
                        child: Text(
                          'Credits',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  Text('Coding and Design By:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Ryan Brockey & Cole Petroccione',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                  Text(
                      'Please send feedback and questions to:\n\hello@justcole.design',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                  SizedBox(height: 20),
                  Text('A 12am Concepts App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      'check out the 12am Podcast and Blog posts to learn more.\n\anchor.fm/12am-concepts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                  SizedBox(height: 20),]),
                  Expanded(flex: 1, child: Row()),
                ]),
          ),
        
      ],
    ),
    );
  }
}
