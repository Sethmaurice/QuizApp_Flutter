import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mid_flutter/UI/welcome_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double lat = -1.9439;
  double long = 30.0605;

  final Uri _url =
      Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/users.json');

  Future<void> _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter username and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.get(_url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      String userEmail = '';
      String userRole = ''; // Add user role

      // Check if username and password match
      extractedData.forEach((key, value) {
        if (value['username'] == username && value['password'] == password) {
          userEmail = value['email'];
          userRole = value['role']; // Retrieve user role
        }
      });

      if (userEmail.isNotEmpty) {
        // Navigate to different screens based on user role
        if (userRole == 'admin') {
          // Navigate to AdminScreen
          Navigator.pushReplacementNamed(context, '/admin', arguments: userRole);
        } else if (userRole == 'user') {
          // Navigate to WelcomeScreen and pass userEmail and userRole
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(userEmail: userEmail, userRole: userRole),
            ),
          );
        } else {
          // Show error message for invalid role
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid role'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Show error message if username and password don't match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error logging in: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return currentPosition;
    } catch (error) {
      print('Error getting current location: $error');
      return null;
    }
  }

Future<void> _openMap(double lat, double long) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  try {
    await canLaunch(googleUrl) ? await launch(googleUrl) : throw 'Could not launch $googleUrl';
  } catch (error) {
    print('Error launching map: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error opening map. Please try again later.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username or Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            // SizedBox(height: 20.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     // Obtain the current location
            //     Position? currentPosition = await _getCurrentLocation();
            //     // Check if currentPosition is not null
            //     if (currentPosition != null) {
            //       // Set the lat and long variables with the obtained coordinates
            //       setState(() {
            //         lat = currentPosition.latitude;
            //         long = currentPosition.longitude;
            //       });
            //       // Open the map with the obtained coordinates
            //       _openMap(lat, long);
            //     } else {
            //       // Handle case where current location couldn't be obtained
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Failed to get current location'),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //     }
            //   },
            //   child: const Text('Open Map => Current Location'),
            // ),
          ],
        ),
      ),
    );
  }
}