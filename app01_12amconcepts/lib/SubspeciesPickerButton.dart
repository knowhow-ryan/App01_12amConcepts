import 'package:flutter/material.dart';
import 'Strain.dart';

class SubspeciesPickerButton extends StatelessWidget {
  final Sub_species subspecies;
  final bool selected;

  final Color borderSelected = Colors.white70;
  final Color borderDeselected = Colors.black54;
  final Color fillSelected = Colors.white70;
  final Color fillDeselected = Colors.black54;
  final Color textSelected = Colors.black;
  final Color textDeselected = Colors.white;

  SubspeciesPickerButton ({@required this.subspecies, @required this.selected});

  @override
  build(BuildContext context) {
    String subspeciesString = this.subspecies.toString().split('.').last;
    Color fill;
    Color border;
    Color text;

    if(this.selected) {
      fill = fillSelected;
      border = borderSelected;
      text = textSelected;
    }
    else {
      fill = fillDeselected;
      border = borderDeselected;
      text = textDeselected;
    }

    return button(subspeciesString, fill, border, text);
  }

  Widget button(subspecies, fill, border, text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8,8,10),
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: border,),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10,18, 10),
          child: Text(subspecies,
            style: TextStyle(color: text),
          ),
        ),
      ),
    );
  }
}