import 'package:flutter/material.dart';
import 'package:mid_flutter/constants.dart';

class ResultBox extends StatelessWidget {
  
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLenght,
    required this.onPressed,
  }) : super(key: key);
  final int result;
  final int questionLenght;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: Padding(padding: const EdgeInsets.all(70.0),
      child: 
       Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const Text('Result',
           style: TextStyle(color: neutral, fontSize: 22.0),
           ),
           const SizedBox(height: 20.0,),
           CircleAvatar(child: Text('$result/$questionLenght', style: TextStyle(fontSize: 28.0),),
           radius: 60.0,
           backgroundColor: result ==  questionLenght/2 ? Colors.yellow
            : result < questionLenght/2 
            ? incorrect 
            : correct,
           ),
           const SizedBox(height: 20.0),
           Text(
            result ==  questionLenght/2 ? 'Almost there'
            : result < questionLenght/2 
            ? 'Failed try again' 
            : 'God job',
            style: const TextStyle(color: neutral),
           ),
          const SizedBox(height: 25.0,),
          GestureDetector(
            onTap: onPressed,
            child: const Text('startOver', 
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
              letterSpacing: 1.0,
            ),),
          )
        ],
      ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context).pop(); // Close the dialog
      //     },
      //     child: Text('OK'),
      //   ),
      // ],
    );
  }
}
