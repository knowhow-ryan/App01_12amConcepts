// OLD DEPRECATED FILE

// import 'package:flutter/material.dart';

// class StrainCard extends StatefulWidget {
//   final String strainName;
//   StrainCard(this.strainName);
//   @override 
//   CardState createState() => CardState(strainName);
// }
// }

// class CardState extends State<StrainCard>{
//   String strainName;
//   CardState(this.strainName);

//   @override
//   Widget build(BuildContext context){
//     return Text(widget.strainName);
//   }
// }



// class StrainCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//       padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
//       //height: MediaQuery.of(context).copyWith().size.height * .45,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(width: 2.0, color:Colors.purple),
//         color: Colors.black87,
//       ),
//       child: Row(
//         children: <Widget>[
//         Stack(children: <Widget>[ 
//           Container( //Card Container
//             padding: EdgeInsets.only(top:MediaQuery.of(context).copyWith().size.height * .03,),
//             width: MediaQuery.of(context).copyWith().size.width * .95,
//             child: 
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container( //Card
//                   height:MediaQuery.of(context).copyWith().size.width * .35,
//                   decoration: BoxDecoration(
//                     color: Colors.black87,
//                     gradient: LinearGradient(
//                       colors: [Colors.grey, Colors.grey],
//                       begin: Alignment.bottomRight,
//                       end: Alignment.topLeft,
                      
//                       ),
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(12.0),
//                     boxShadow:[ BoxShadow(
//                       color: Colors.black12,
//                       blurRadius:10,
//                       offset: Offset(0.0, 10),
//                     ),]
//                   ),
//                   margin: EdgeInsets.only(left:MediaQuery.of(context).copyWith().size.width * .25,),
//                   padding: EdgeInsets.only(left:MediaQuery.of(context).copyWith().size.width * .125,),
//                   child: Column(children: <Widget>[
                    
//                      ListTile(
//                     title:Text("Gorilla Glue #12"),
//                     subtitle: Text("from K9 Kronic"),
//                   ),
                  
//                   Row(children: <Widget>[
//                     Text("%%THC"),
//                     SizedBox(width:MediaQuery.of(context).copyWith().size.width * .025,),
//                     Text("%%CBD"),
//                     Text("DATE"),
//                   ],)
//                   ],)
//                 ),
//               ],
//             ),
//           ),
//           Container( //Strain Image - Need to decide default image
//             margin: EdgeInsets.fromLTRB(12, 28, 12, 12),
//             width:MediaQuery.of(context).copyWith().size.width * .32,
//             height:MediaQuery.of(context).copyWith().size.width * .32,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               border: Border.all(width: 2.0, color: Colors.pink),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                   "http://justcole.design/wp-content/uploads/2019/12/weed@0.25x.png"
//                   )))),
//           Positioned( //Rating Number Container
//             left:5,
//             bottom:5,
//             child: Container(
//             padding: EdgeInsets.all(13.0),
            
//             decoration: BoxDecoration(
//               shape:BoxShape.circle,
//               color: Colors.black,
//               border: Border.all(width:2.0, color: Colors.cyan),),
//               child: 
//                 Text("01",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 )),
//             ),
//           ),
//         ],
//       ), // outermost widget
        
//         ],),
//     );
//   }
// }