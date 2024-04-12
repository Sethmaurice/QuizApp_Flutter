import 'package:flutter/material.dart';
import 'package:mid_flutter/UI/home_screen.dart';
import 'package:mid_flutter/UI/countdown_screen.dart';

class Quiz {
  final String title;
  final int durationInMilliseconds;

  Quiz({required this.title, required this.durationInMilliseconds});
}

class AvailableQuizzes extends StatelessWidget {
  final List<Quiz> quizzes = [
    Quiz(title: 'Quiz 1', durationInMilliseconds: 30000), // 30 seconds
    Quiz(title: 'Quiz 2', durationInMilliseconds: 60000), // 1 minute
    // Add more quizzes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Quizzes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Exam App!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _CountdownScreenWrapper()),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountdownScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownScreen(
      durationInMilliseconds: 0, // Set to 0 as a placeholder, actual duration will be set in AvailableQuizzes
      onCountdownEnd: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }
}
