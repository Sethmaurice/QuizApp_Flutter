import 'package:flutter/material.dart';

class DefineTimer extends StatefulWidget {
  @override
  _DefineTimerState createState() => _DefineTimerState();

  // Add this method to access the timer duration
  static int getTimerDuration(BuildContext context) {
    final state = context.findAncestorStateOfType<_DefineTimerState>();
    return state?._selectedDuration ?? 30; // Default duration is 30 seconds
  }
}

class _DefineTimerState extends State<DefineTimer> {
  int _selectedDuration = 10; // Default duration is 30 seconds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Timer Duration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Timer Duration:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DropdownButton<int>(
              value: _selectedDuration,
              onChanged: (int? value) {
                setState(() {
                  _selectedDuration = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 30,
                  child: Text('10 seconds'),
                ),
                DropdownMenuItem<int>(
                  value: 60,
                  child: Text('1 minute'),
                ),
                // Add more duration options as needed
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedDuration);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
