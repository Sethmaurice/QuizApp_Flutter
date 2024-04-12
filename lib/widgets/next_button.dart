// import 'package:flutter/material.dart';
// import 'package:mid_flutter/constants.dart';

// class NextButton extends StatelessWidget {
//   const NextButton({super.key, required this.nextQuestion});
//   final VoidCallback nextQuestion;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: nextQuestion,
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: neutral,
//           borderRadius: BorderRadius.circular(10.0)
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 10.0),
//         child: const Text('Next Question',
//         textAlign: TextAlign.center,),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mid_flutter/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: const Text(
        'Next Question',
        textAlign: TextAlign.center,
        // style: TextStyle(
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        ),
      );
  }
}
