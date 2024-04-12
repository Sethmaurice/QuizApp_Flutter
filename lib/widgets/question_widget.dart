// import 'package:flutter/material.dart';
// import 'package:mid_flutter/constants.dart';

// class QuestionWidget extends StatelessWidget {
//   const QuestionWidget({
//     Key? key,
//     required this.question,
//     required this.indexAction,
//     required this.totalQuestions,
//   }) : super(key: key);

//   final String question;
//   final int indexAction;
//   final int totalQuestions;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         'Question ${indexAction + 1}/$totalQuestions: $question',
//         style: TextStyle(
//           fontSize: 24,
//           color: neutral,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:mid_flutter/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.questionId, // Add questionId parameter
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
  }) : super(key: key);

  final String questionId; // Declare questionId parameter
  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ID: $questionId', // Display question ID
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Question ${indexAction + 1}/$totalQuestions: $question',
            style: TextStyle(
              fontSize: 24,
              color: neutral,
            ),
          ),
        ],
      ),
    );
  }
}
