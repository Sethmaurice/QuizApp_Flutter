// import 'package:flutter/material.dart';
// import 'package:mid_flutter/constants.dart';
// import 'package:mid_flutter/models/question_model.dart';
// import 'package:mid_flutter/widgets/next_button.dart';
// import 'package:mid_flutter/widgets/option_card.dart';
// import 'package:mid_flutter/widgets/question_widget.dart';
// import 'package:mid_flutter/widgets/result_box.dart';
// import 'package:mid_flutter/models/db_connect.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future<List<Question>> _questions;
//   var db = DBconnect();

//   @override
//   void initState() {
//     _questions = db.fetchQuestions();
//     super.initState();
//   }

//   int index = 0;
//   int score = 0;
//   bool isPressed = false;
//   bool isAlreadySelected = false;

//   void checkAnswerAndUpdate(bool value) {
//     if (isAlreadySelected) {
//       return;
//     } else {
//       if (value == true) {
//         score++;
//       }
//       setState(() {
//         isPressed = true;
//         isAlreadySelected = true;
//       });
//     }
//   }

//   void startOver() {
//     setState(() {
//       index = 0;
//       score = 0;
//       isPressed = false;
//       isAlreadySelected = false;
//     });
//     Navigator.pop(context);
//   }

//   void nextQuestion(int questionLength) async {
//     List<Question> questions = await _questions;

//     if (questions.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No questions available'),
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.symmetric(vertical: 20.0),
//         ),
//       );
//       return;
//     }

//     if (index >= questionLength - 1) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (ctx) => ResultBox(
//           result: score,
//           questionLenght: questionLength,
//           onPressed: startOver,
//         ),
//       );
//     } else {
//       if (isPressed) {
//         setState(() {
//           index = (index + 1) % questionLength;
//           isPressed = false;
//           isAlreadySelected = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select any option'),
//             behavior: SnackBarBehavior.floating,
//             margin: EdgeInsets.symmetric(vertical: 20.0),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: _questions,
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else if (snapshot.hasData) {
//           List<Question> questions = snapshot.data!;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Quiz App'),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Text(
//                     'Score: $score',
//                     style: const TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//               ],
//             ),
//             body: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 children: [
//                   QuestionWidget(
//                       questionId: questions[index].id,
//                     indexAction: index,
//                     question: questions[index].title,
//                     totalQuestions: questions.length,
//                   ),
//                   const Divider(color: Colors.black),
//                   const SizedBox(height: 25.0),
//                   for (int i = 0; i < questions[index].options.length; i++)
//                     GestureDetector(
//                       onTap: () =>
//                           checkAnswerAndUpdate(questions[index].options.values.toList()[i]),
//                       child: OptionCard(
//                         option: questions[index].options.keys.toList()[i],
//                         color: isPressed
//                             ? questions[index].options.values.toList()[i] == true
//                             //COLOR CHANGE
//                                 ? Colors.green
//                                 : Colors.red
//                             : Colors.white,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             floatingActionButton: GestureDetector(
//               onTap: () => nextQuestion(questions.length),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: NextButton(),
//               ),
//             ),
//             floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//           );
//         } else {
//           return const Center(child: Text('No data'));
//         }
//       },
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mid_flutter/constants.dart';
import 'package:mid_flutter/models/question_model.dart';
import 'package:mid_flutter/widgets/next_button.dart';
import 'package:mid_flutter/widgets/option_card.dart';
import 'package:mid_flutter/widgets/question_widget.dart';
import 'package:mid_flutter/widgets/result_box.dart';
import 'package:mid_flutter/models/db_connect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Question>> _questions;
  var db = DBconnect();
  late int _quizDurationInSeconds;
  late Timer _timer;
  late int _currentSeconds;
  bool _timerPaused = false;

  @override
  void initState() {
    super.initState();
    _questions = db.fetchQuestions();
    _quizDurationInSeconds = 20; // Set quiz duration to 20 seconds
    _currentSeconds = _quizDurationInSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        timer.cancel();
        submitQuiz();
      } else {
        setState(() {
          _currentSeconds--;
        });
      }
    });
  }

  void submitQuiz() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => ResultBox(
        result: score,
        questionLenght: questionLength,
        onPressed: startOver,
      ),
    );
  }

  void startOver() {
    _currentSeconds = _quizDurationInSeconds;
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
    startTimer();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  int questionLength = 0;

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void nextQuestion() async {
    List<Question> questions = await _questions;
    if (index < questions.length - 1) {
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected = false;
      });
    } else {
      if (_timer.isActive) {
        _timer.cancel();
      }
      submitQuiz();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          List<Question> questions = snapshot.data!;
          questionLength = questions.length;
          return Scaffold(
            appBar: AppBar(
              title: Text('Quiz App'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Score: $score',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Time Left: $_currentSeconds seconds',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  QuestionWidget(
                    questionId: questions[index].id,
                    indexAction: index,
                    question: questions[index].title,
                    totalQuestions: questions.length,
                  ),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 25.0),
                  for (int i = 0; i < questions[index].options.length; i++)
                    GestureDetector(
                      onTap: () =>
                          checkAnswerAndUpdate(questions[index].options.values.toList()[i]),
                      child: OptionCard(
                        option: questions[index].options.keys.toList()[i],
                        color: isPressed
                            ? questions[index].options.values.toList()[i] == true
                            //COLOR CHANGE
                                ? Colors.green
                                : Colors.red
                            : Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            floatingActionButton: GestureDetector(
              onTap: nextQuestion,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: NextButton(),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
