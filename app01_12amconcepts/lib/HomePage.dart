import 'package:flutter/material.dart';
// import 'StrainCard.dart';

class HomePage extends StatelessWidget {
  

  //this is a container for all of the strain information, like name, location, thc, etc.


  //this is a constructor that pulls in the Strain object information and puts it in the strain container above


  @override
  Widget build(BuildContext context) {
    
    return
      Stack(
        children: <Widget>[
          Container( //Starting Gradient with Smoke Background
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: FractionalOffset.topCenter,
                    begin: FractionalOffset.bottomCenter,
                    stops: [.05, .45,],
                    colors: [Color(0xFFDDDDDD), Colors.black87,],
                  ),
                  ),
                child: Image.network("http://justcole.design/wp-content/uploads/2020/01/Smokey-Background.png",
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.overlay,
                ),
                ),
                
        ],
      );
}}
  