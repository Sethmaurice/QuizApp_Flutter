import 'package:flutter/material.dart';
import 'package:mid_flutter/models/db_connect.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'user';

  final DBconnect _dbConnect = DBconnect();

   void _signup(BuildContext context) {
    String username = _usernameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String role = _selectedRole;

    // Call the addUser method to save user data to Firebase
    _dbConnect.addUser(username, email, phone, password, role);

    // Navigate to the home screen or perform any other action after successful signup
    Navigator.pushReplacementNamed(context, '/login');
  


    // Validate input fields
    if (username.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Proceed with signup
    // You can replace this logic with your actual signup process
    // For now, let's just print the user details
    print('Username: $username, Email: $email, Phone: $phone, Password: $password, Role: $_selectedRole');

    // Navigate to the home screen after successful signup
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
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
            DropdownButton<String>(
              value: _selectedRole,
              items: [
                DropdownMenuItem(
                  child: Text('Admin'),
                  value: 'admin',
                ),
                DropdownMenuItem(
                  child: Text('User'),
                  value: 'user',
                ),
              ],
              onChanged: (value) {
                // Update the selected role when the dropdown value changes
                _selectedRole = value!;
              },
              hint: Text('Select Role'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _signup(context),
              child: Text('Signup'),
            ),
                       SizedBox(height: 20.0),
ElevatedButton(
  onPressed: () {
    // Navigate to the specified route when the button is clicked
    Navigator.pushNamed(context, '/login');
  },
  child: Text('Login here'),
),
          ],
        ),
      ),
    );
  }
}
