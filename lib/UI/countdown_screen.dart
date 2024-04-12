import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownScreen extends StatelessWidget {
  final int durationInMilliseconds;
  final VoidCallback onCountdownEnd;

  const CountdownScreen({
    Key? key,
    required this.durationInMilliseconds,
    required this.onCountdownEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCountdownTimer(
              durationInMilliseconds: durationInMilliseconds,
              onCountdownEnd: onCountdownEnd,
            ),
            SizedBox(height: 20), // Add some spacing between countdown timer and text
            Text(
              'Success is not final, failure is not fatal: It is the courage to continue that counts', // Replace with your text
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Example styling
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCountdownTimer extends StatefulWidget {
  final int durationInMilliseconds;
  final VoidCallback onCountdownEnd;

  const AnimatedCountdownTimer({
    Key? key,
    required this.durationInMilliseconds,
    required this.onCountdownEnd,
  }) : super(key: key);

  @override
  _AnimatedCountdownTimerState createState() => _AnimatedCountdownTimerState();
}

class _AnimatedCountdownTimerState extends State<AnimatedCountdownTimer> {
  late int _endTime;
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().millisecondsSinceEpoch + widget.durationInMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      endTime: _endTime,
      textStyle: TextStyle(
        fontSize: 24,
        color: _textColor,
      ),
      onEnd: () {
        widget.onCountdownEnd();
      },
    );
  }
}
