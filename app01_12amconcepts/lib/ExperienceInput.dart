import 'package:flutter/material.dart';

class ExperienceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:35, left:12,right:12,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:5,bottom: 5,),
            child:
            Text('What Strain?',
            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            )),
          ),
          Container(
            height:50,
              child: Row(
            children: <Widget>[
              
              Expanded(
               
                child: Container(
                  decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
                  child: TextField(
                   
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                      
                        hintText: "Highly Rated",
                        hintStyle: TextStyle(fontSize: 15),
                    )
                  ),
                ),
              ),
              
            ],
          )),
          Row(
            children: <Widget>[
              Padding(
                       padding: const EdgeInsets.only(left:4,right:4,top:5,),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,12,8),
                            child: Center(
                              child: Text("happy",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  )),
                            ),
                          )),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
