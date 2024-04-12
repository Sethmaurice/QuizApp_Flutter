// import 'package:flutter/material.dart';
// import 'package:mid_flutter/UI/home_screen.dart';
// import 'package:mid_flutter/admin/add_quiz_screen.dart';
// import 'package:mid_flutter/admin/admin_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mid_flutter/log/login_screen.dart';
// import 'package:mid_flutter/log/signup_screen.dart';
// import 'package:mid_flutter/UI/notification_screen.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mid_flutter/location_manager.dart';



// void main(){
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MID TERM',
//       debugShowCheckedModeBanner: false,
//     //  home: HomeScreen(),
//     home: SignupScreen(),
//       routes: {
//         '/home': (context) => HomeScreen(),
//         '/signup': (context) => SignupScreen(),
//         '/addQuiz': (context) => AddQuizScreen(),
//         '/notifications': (context) => NotificationScreen(),
//         '/admin': (context) => AddQuizScreen(),
//         '/login': (context) => LoginScreen(),


//       },
//     );
    
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

  

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {



//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _getCurrentLocation(context);
//           },
//           child: Text('Get Current Location'),
//         ),
//       ),
//     );
//   }

//   void _getCurrentLocation(BuildContext context) async {
//     Position? currentPosition = await LocationManager().getCurrentLocation();
//     if (currentPosition != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               'Current Location: ${currentPosition.latitude}, ${currentPosition.longitude}'),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to get current location'),
//         ),
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:mid_flutter/UI/home_screen.dart';
import 'package:mid_flutter/admin/add_quiz_screen.dart';
import 'package:mid_flutter/admin/admin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mid_flutter/ass/Welcome.dart';
import 'package:mid_flutter/log/login_screen.dart';
import 'package:mid_flutter/log/signup_screen.dart';
import 'package:mid_flutter/UI/notification_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mid_flutter/location_manager.dart';
import 'package:provider/provider.dart';
import 'package:mid_flutter/ass/theme_notifier.dart'; // Import ThemeNotifier class
import 'package:mid_flutter/main.dart'; // Import MyApp class

void main(){
  runApp(
        ChangeNotifierProvider<ThemeNotifier>(

      create: (_) => ThemeNotifier(ThemeMode.light),

          child: MyAppWrapper(), // Wrap MyApp with MyAppWrapper

    ),
  );
}
class MyAppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(), // MyApp is now the home of MaterialApp
    );
  }
}
// class ThemeNotifier extends ValueNotifier<ThemeMode> {
//   ThemeNotifier(ThemeMode value) : super(value);

//   void toggleTheme() {
//     value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//   }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MID TERM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeNotifier>().value,
      home: SignupScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/addQuiz': (context) => AddQuizScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/admin': (context) => AddQuizScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      // actions: [
      //     IconButton(
      //       icon: Icon(Icons.dark_mode),
      //       onPressed: () {
      //         context.read<ThemeNotifier>().toggleTheme();
      //       },
      //     ),
      //   ],
      ),
      // drawer: NavBar(),
      body: Welcome(),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           _getCurrentLocation(context);
      //         },
      //         child: Text('Get Current Location'),
      //       ),
      //       SizedBox(height: 20),
      //       if (_currentPosition != null)
      //         Text(
      //           'Current Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}',
      //         ),
      //     ],
      //   ),
      // ),
    );
  }

  void _getCurrentLocation(BuildContext context) async {
    try {
      Position? currentPosition = await LocationManager().getCurrentLocation();
      if (currentPosition != null) {
        setState(() {
          _currentPosition = currentPosition;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Current Location: ${currentPosition.latitude}, ${currentPosition.longitude}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get current location'),
          ),
        );
      }
    } catch (error) {
      print('Error getting current location: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while getting location.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}




// import 'package:flutter/material.dart';
// import 'package:mid_flutter/UI/available_quizes.dart';
// import 'package:mid_flutter/UI/home_screen.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart'; // Add this import

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MID TERM',
//       debugShowCheckedModeBanner: false,
//       // home: MyHomePage(title: 'Welcome to Our Online Quiz'),
//       home: HomeScreen(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   void _startQuiz(BuildContext context) async {
//     final bool ready = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Are you ready to start your quiz?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // Yes, ready to start
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // No, stay on this page
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );

//     if (ready == true) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'WELCOME TO OUR ONLINE QUIZ',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             CountdownTimer(
//               endTime: DateTime.now().millisecondsSinceEpoch + 10000,
//               textStyle: TextStyle(fontSize: 24),
//               onEnd: () => _startQuiz(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
