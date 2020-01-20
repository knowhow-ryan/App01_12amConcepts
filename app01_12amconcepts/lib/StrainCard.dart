import 'package:flutter/material.dart';

class StrainPage extends StatelessWidget {
  //based on the tutorial: https://flutterbyexample.com/reusable-custom-card-widget/

  //this is a container for all of the strain information, like name, location, thc, etc.
  final Strain strain;

  //this is a constructor that pulls in the Strain object information and puts it in the strain container above
  StrainPage(this.strain);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFCCCCCC),
      child: Column(
        children: <Widget>[
          Container(
            //Strain Info Page
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
              ),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black38,
                  blurRadius: 8.0,
                ),
              ],
              gradient: LinearGradient(
                end: FractionalOffset.bottomRight,
                begin: FractionalOffset.topLeft,
                stops: [
                  .4,
                  .7,
                ],
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFedccb3),
                ],
              ),
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  height: 40,
                  width: 80,
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
                                fontSize: 12,
                              )),
                        )),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  //width: 100,

                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                          ),
                          color: Colors.green,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
                          ))),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
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
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Divider(
                color: Colors.black45,
              ))
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[//TO DO: why are you centered?
                 Text("Experiences",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//StrainCards build method
//   @override
//   Widget build(BuildContext context) {
//     return
//       Column(
//         children: <Widget>[
//           Container( //Sativa Orange Card
//             height:100,
//             decoration:

//             BoxDecoration(

//                             borderRadius: BorderRadius.all(Radius.circular(12.0),),
//                             boxShadow:[
//             new BoxShadow(
//               color: Colors.black38,
//               blurRadius: 8.0,
//             ),
//           ],
//                             gradient: LinearGradient(
//                         end: FractionalOffset.bottomRight,
//                         begin: FractionalOffset.topLeft,
//                         stops: [.4, .7,],
//                         colors: [
//                           Color(0xFFFFFFFF),
//                           Color(0xFFedccb3),
//                         ],

//                       ), //Sativa Orange gradient

//                           ),

//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Stack(
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.all(12),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 Text(strain.name,
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:22,
//                                     )
//                                 ),
//                                 SizedBox(height:2,),
//                                 Text(strain.location,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:18,
//                                     )
//                                 ),
//                                 SizedBox(height:3,),
//                                 Row(
//                                   children: <Widget>[

//                                     Text('THC: ${strain.thc}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                     SizedBox(width:15,),
//                                     Text('CBD: ${strain.cbd}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     ),),
//                                     SizedBox(width:15,),
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.black54,
//                                       size:15,
//                                     ),
//                                     Text(': ${strain.rating}',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                         ),

//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           width: 100,
//                           height:100,
//                           child: Container(
//                             decoration: BoxDecoration(

//                               borderRadius: BorderRadius.only(topRight:Radius.circular(12.0), bottomRight:Radius.circular(12.0), bottomLeft: Radius.circular(50.0), topLeft: Radius.circular(50.0),),
//                               color: Colors.green,
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage("https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
//                               )
//                             )

//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
//                 ],

//             ),
//           ),
//           SizedBox(height:12),
//           Container( //Indica Purple Card
//             height:100,
//             decoration:

//             BoxDecoration(

//                             borderRadius: BorderRadius.all(Radius.circular(12.0),),
//                             boxShadow:[
//             new BoxShadow(
//               color: Colors.black38,
//               blurRadius: 8.0,
//             ),
//           ],
//                             gradient: LinearGradient(
//                         end: FractionalOffset.bottomRight,
//                         begin: FractionalOffset.topLeft,
//                         stops: [.4, .7,],
//                         colors: [
//                           Color(0xFFFFFFFF),
//                           Color(0xFFceafcc),
//                         ],

//                       ), //Indica Purple Gradient

//                           ),

//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Stack(
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.all(12),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 Text(strain.name,
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:22,
//                                     )
//                                 ),
//                                 SizedBox(height:2,),
//                                 Text(strain.location,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:18,
//                                     )
//                                 ),
//                                 SizedBox(height:3,),
//                                 Row(
//                                   children: <Widget>[

//                                     Text('THC: ${strain.thc}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                     SizedBox(width:15,),
//                                     Text('CBD: ${strain.cbd}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     ),),
//                                     SizedBox(width:15,),
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.black54,
//                                       size:15,
//                                     ),
//                                     Text(': ${strain.rating}',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                         ),

//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           width: 100,
//                           height:100,
//                           child: Container(
//                             decoration: BoxDecoration(

//                               borderRadius: BorderRadius.only(topRight:Radius.circular(12.0), bottomRight:Radius.circular(12.0), bottomLeft: Radius.circular(50.0), topLeft: Radius.circular(50.0),),
//                               color: Colors.green,
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage("https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
//                               )
//                             )

//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
//                 ],

//             ),
//           ),
//           SizedBox(height:12),
//           Container( //Hybrid Green Card
//             height:100,
//             decoration:

//             BoxDecoration(

//                             borderRadius: BorderRadius.all(Radius.circular(12.0),),
//                             boxShadow:[
//             new BoxShadow(
//               color: Colors.black38,
//               blurRadius: 8.0,
//             ),
//           ],
//                             gradient: LinearGradient(
//                         end: FractionalOffset.bottomRight,
//                         begin: FractionalOffset.topLeft,
//                         stops: [.4, .7,],
//                         colors: [
//                           Color(0xFFFFFFFF),
//                           Color(0xFFb2d3bf),
//                         ],

//                       ), //Hybrid Green Gradient

//                           ),

//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Stack(
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.all(12),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 Text(strain.name,
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:22,
//                                     )
//                                 ),
//                                 SizedBox(height:2,),
//                                 Text(strain.location,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:18,
//                                     )
//                                 ),
//                                 SizedBox(height:3,),
//                                 Row(
//                                   children: <Widget>[

//                                     Text('THC: ${strain.thc}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                     SizedBox(width:15,),
//                                     Text('CBD: ${strain.cbd}%',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     ),),
//                                     SizedBox(width:15,),
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.black54,
//                                       size:15,
//                                     ),
//                                     Text(': ${strain.rating}',
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:15,
//                                     )
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                         ),

//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           width: 100,
//                           height:100,
//                           child: Container(
//                             decoration: BoxDecoration(

//                               borderRadius: BorderRadius.only(topRight:Radius.circular(12.0), bottomRight:Radius.circular(12.0), bottomLeft: Radius.circular(50.0), topLeft: Radius.circular(50.0),),
//                               color: Colors.green,
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage("https://media1.fdncms.com/illinoistimes/imager/u/original/11623518/news01.jpg"),
//                               )
//                             )

//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
//                 ],

//             ),
//           ),
//         ],
//       );

//   }
// }


//This is a dummy strain so you have data you can insert into the UI
//you access this information by using strain.name, strain.thc, etc.
class Strain {
  String name;
  double thc;
  double cbd;
  double rating;
  String date;
  String location;
  String genetics;

  Strain() {
    this.name = "Jedi Killer Kush";
    this.thc = 18.5;
    this.cbd = 2.3;
    this.rating = 4.7;
    this.date = "04/20/20";
    this.location = "Destroyer's Burger Cave";
    this.genetics = "Sativa";
  }
}


