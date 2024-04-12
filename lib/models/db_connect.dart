import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mid_flutter/models/question_model.dart';

class DBconnect {
  final Uri _url = Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/users.json');
  final Uri _urlq = Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/questions.json');


  Future<void> addUser(String username, String email, String phone, String password, String role) async {
    try {
      final response = await http.post(
        _url,
        body: json.encode({
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        print('User added successfully');
      } else {
        print('Failed to add user');
      }
    } catch (error) {
      print('Error adding user: $error');
    }
  }

  Future<String?> getUserEmail(String userId) async {
    try {
      final response = await http.get(_url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the user with the given userId exists in the database
        if (data.containsKey(userId)) {
          return data[userId]['email'];
        } else {
          print('User with ID $userId not found');
          return null;
        }
      } else {
        print('Failed to retrieve user data');
        return null;
      }
    } catch (error) {
      print('Error retrieving user email: $error');
      return null;
    }
  }

 Future<List<Question>> fetchQuestions() async {
  try {
    final response = await http.get(_urlq);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData); // Print the response body to see its format

      // Convert the response data to a list of Question objects
      List<Question> questions = [];
      responseData.forEach((key, value) {
        questions.add(Question.fromJson({
          'id': key,
          'title': value['title'],
          'options': value['options'],
        }));
      });

      return questions;
    } else {
      throw Exception('Failed to fetch questions. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching questions: $error');
    return []; // Return an empty list in case of error
  }
}
 
 Future<void> addQuestion(String title, List<Map<String, dynamic>> options) async {
    try {
      final response = await http.post(
        _urlq,
        body: json.encode({
          'title': title,
          'options': options,
        }),
      );

      if (response.statusCode == 200) {
        print('Question added successfully');
      } else {
        print('Failed to add question');
      }
    } catch (error) {
      print('Error adding question: $error');
    }
  }

  // Other methods in the DBconnect class...
}
