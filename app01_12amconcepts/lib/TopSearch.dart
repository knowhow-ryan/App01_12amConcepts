import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 45, 12, 15),
      child: Container(
        height:50,
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.cannabis, color: Colors.white,),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {},
            ),
          ),
          Expanded(
           flex:6,
            child: Container(
              decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
              child: TextField(
               
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  suffixIcon: Icon(Icons.search) ,
                    hintText: "Highly Rated",
                    hintStyle: TextStyle(fontSize: 17),
                )
              ),
            ),
          ),
          Expanded(
            flex:1,
            child:
            IconButton(
              icon: Icon(FontAwesomeIcons.sort, color: Colors.white,),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {},
            ),
          )
        ],
      )),
    );
  }
}
