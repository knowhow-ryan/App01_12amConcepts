import 'package:flutter/material.dart';

class StrainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Stack(children: <Widget>[
          Container(
            width:150,
            height:150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2.0, color: Colors.red),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "http://justcole.design/wp-content/uploads/2019/12/weed@0.25x.png"
                  )))),
          Positioned(
            left:5,
            bottom:5,
            child: Container(
            padding: EdgeInsets.all(10.0),
            
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              color: Colors.white,
              border: Border.all(width:2.0, color: Colors.black),),
              child: Text("01"),
            )
          )
        ],
      )
        ] 
    ); // outermost widget
  }
}