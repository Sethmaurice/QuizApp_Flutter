import 'package:mid_flutter/NavBar.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xff383837),
        // Add hamburger icon to open the drawer
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold(
        //           drawer: NavBar(),
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
            SizedBox(
                height: 20), // Add some space between the text and the image
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/010/925/820/non_2x/colorful-welcome-design-template-free-vector.jpg', // Replace 'welcome_image.png' with your image asset path
              width: 200, // Adjust the width as needed
            ),
          ],
        ),
      ),
    );
  }
}
