// import 'package:app01_12amconcepts/NewExperiencePage.dart';
import 'package:flutter/material.dart';
// import 'ExperienceInput.dart';

class ExperienceInputStep2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
    //    floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //         Navigator.of(context).push(_createRoute());
    //       },
          
    //   child: Icon(Icons.done),
    //   backgroundColor: Color(0xFF8BD3A8),
    // ),
      body:
    Stack(
      children: <Widget>[
        
        Container( //Starting Gradient with Smoke Background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: FractionalOffset.topCenter,
              begin: FractionalOffset.bottomCenter,
              stops: [
                .6,
                .9,
              ],
              colors: [
                Color(0xFFDDDDDD),
                Colors.black87,
              ],
            ),
          ),
          child: Image.network(
            "http://justcole.design/wp-content/uploads/2020/01/Smokey-Background.png",
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.overlay,
          ),
        ),
    Padding(
      padding: const EdgeInsets.only(top:35, left:12,right:12,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:5,bottom: 5,),
            child:
            Text('Jedi Killer',
            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            )),
          ),
          Padding(
            padding: EdgeInsets.only(left:5,bottom: 15,),
            child:
            Text('How so?',
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
                      
                        hintText: "Joe's House",
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
       )] ));
  }
}
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => NewExperiencePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }