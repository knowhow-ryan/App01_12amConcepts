import 'package:flutter/material.dart';

class TopSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:25,bottom:15,),
      child: Container(
        height:50,
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.home),
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
              icon: Icon(Icons.compare_arrows),
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
