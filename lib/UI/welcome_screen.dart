// import 'package:flutter/material.dart';
// import 'package:mid_flutter/models/db_connect.dart'; 
// import 'package:mid_flutter/UI/home_screen.dart';

// class WelcomeScreen extends StatelessWidget {
//   final String userEmail; // Pass the user email to the WelcomeScreen

//   WelcomeScreen({required this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome'),
//         actions: [
//           IconButton(
//   icon: Icon(Icons.logout),
//   onPressed: () {
//     // Navigate back to the login screen
//     Navigator.pushReplacementNamed(context, '/login');
//   },
// ),

//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Navigate to the notification screen
//               Navigator.pushNamed(context, '/notifications');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome, $userEmail',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Thank you for choosing us! We appreciate your trust.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 40),
// ElevatedButton(
//   onPressed: () {
//     // Navigate to the screen for attempting questions
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   },
//   child: Text('Attempt Questions'),
// ),

//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:mid_flutter/NavBar.dart';
import 'package:mid_flutter/models/db_connect.dart'; 
import 'package:mid_flutter/UI/home_screen.dart';
import 'package:mid_flutter/UI/countdown_screen.dart';
import 'package:provider/provider.dart';
import 'package:mid_flutter/main.dart';
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier(ThemeMode value) : super(value);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
class WelcomeScreen extends StatelessWidget {
  final String userEmail; // Pass the user email to the WelcomeScreen
  final String userRole; // Add userRole parameter

  WelcomeScreen({required this.userEmail, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notification screen
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              context.read<ThemeNotifier>().toggleTheme();
            },
          ),
        ],
      ),
      drawer: NavBar(),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome, $userEmail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Thank you for choosing us! We appreciate your trust.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Set the duration of the countdown timer (e.g., 10 seconds)
                    int countdownDuration = 10000; // 10 seconds in milliseconds

                    // Show the countdown screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountdownScreen(
                          durationInMilliseconds: countdownDuration,
                          onCountdownEnd: () {
                            // Navigate to the screen for attempting questions when countdown ends
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Attempt Questions'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
