import 'package:flutter/material.dart';
import 'package:mid_flutter/constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.option,  required this.color});
  final String option;
  // final bool IsClicked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, 
      // ? color: neutral,
      child: ListTile(
        title: Text(option,
        textAlign: TextAlign.center,
         style: TextStyle(fontSize: 22.0,
         color: color.red != color.green ? neutral : Colors.black,
         ),),
      ),
    );
  }
}