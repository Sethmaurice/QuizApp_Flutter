import 'package:flutter/material.dart';

// NotificationService class to manage notifications
class NotificationService {
  static List<String> notifications = []; // List to store notifications

  // Method to add a new notification
  static void addNotification(String notification) {
    notifications.add(notification);
  }

  // Method to clear all notifications
  static void clearNotifications() {
    notifications.clear();
  }
}

// NotificationScreen widget to display notifications
class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: NotificationService.notifications.length,
        itemBuilder: (context, index) {
          final notification = NotificationService.notifications[index];
          return ListTile(
            title: Text(notification),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Clear all notifications when FloatingActionButton is pressed
          NotificationService.clearNotifications();
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}

// Your existing LoginScreen class
class Login extends StatelessWidget {
 final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _login(BuildContext context) async {
    // Existing code for login

    // After successful login, navigate to the NotificationScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationScreen(),
      ),
    );
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
          ],
        ),
      ),
    );
  }

}
