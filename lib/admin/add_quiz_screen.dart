import 'package:flutter/material.dart';
import 'package:mid_flutter/models/db_connect.dart';
import 'package:mid_flutter/models/question_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddQuizScreen extends StatefulWidget {
  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  late Future<List<Question>> _questions = _fetchQuestions(); // Initialize _questions

 Future<List<Question>> _fetchQuestions() async {
  try {
    final response = await http.get(
      Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/questions.json'),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data != null) {
        final List<Question> questions = [];

        if (data is Map<String, dynamic>) {
          // Handle map structure
          data.forEach((key, value) {
            if (value is Map<String, dynamic> && value.containsKey('title') && value.containsKey('options')) {
              questions.add(Question(
                id: key,
                title: value['title'],
                options: Map<String, bool>.from(value['options']),
              ));
            }
          });
        } else if (data is List<dynamic>) {
          // Handle list structure
          for (var item in data) {
            if (item is Map<String, dynamic> && item.containsKey('title') && item.containsKey('options')) {
              questions.add(Question(
                id: item['id'],
                title: item['title'],
                options: Map<String, bool>.from(item['options']),
              ));
            }
          }
        }

        return questions;
      } else {
        throw Exception('Invalid data format: expected a map or list');
      }
    } else {
      throw Exception('Failed to fetch questions: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching questions: $e');
    throw Exception('Failed to fetch questions: $e');
  }
}




  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  bool _isTrueOption = true;
  List<Map<String, dynamic>> _options = [];
  final DBconnect _dbConnect = DBconnect(); 

  void _addOption() {
    if (_optionController.text.isNotEmpty) {
      _options.add({'text': _optionController.text, 'isTrue': _isTrueOption});
      _optionController.clear();
      setState(() {});
    }
  }

  void _submitQuiz() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text.trim();

      List<Map<String, dynamic>> options = [];
      for (var option in _options) {
        options.add({'text': option['text'], 'isTrue': option['isTrue']});
      }

      Map<String, dynamic> formattedQuiz = {
        'title': title,
        'options': options,
      };

      http.post(
        Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/questions.json'),
        body: json.encode(formattedQuiz),
      ).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Quiz posted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          _titleController.clear();
          _optionController.clear();
          _options.clear();

          setState(() {
            _questions = _fetchQuestions(); // Fetch updated questions after adding a new quiz
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to post quiz'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post quiz: $error'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
          actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Add Quiz'),
              Tab(text: 'Check Questions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     TextFormField(
                      controller: _keyController,
                      decoration: InputDecoration(labelText: 'Key'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a key';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Question Title'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a question title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _optionController,
                      decoration: InputDecoration(labelText: 'Option'),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isTrueOption,
                          onChanged: (value) {
                            setState(() {
                              _isTrueOption = value!;
                            });
                          },
                        ),
                        Text('True'),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _addOption,
                      child: Text('Add Option'),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitQuiz,
                      child: Text('Post Quiz'),
                    ),
                    SizedBox(height: 20.0),
                    Text('Options:'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _options
                          .map((option) => Text(
                                '${option['text']} - ${option['isTrue'] ? 'True' : 'False'}',
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            CheckQuestionsScreen(_fetchQuestions), 
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keyController.dispose();
    _titleController.dispose();
    _optionController.dispose();
    super.dispose();
  }
}

class CheckQuestionsScreen extends StatefulWidget {

  final Future<List<Question>> Function() fetchQuestions;

  CheckQuestionsScreen(this.fetchQuestions);

  @override
  _CheckQuestionsScreenState createState() => _CheckQuestionsScreenState();
}

class _CheckQuestionsScreenState extends State<CheckQuestionsScreen> {
  late Future<List<Question>> _questions;

  @override
  void initState() {
    super.initState();
    _questions = widget.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions,
      builder: (context, AsyncSnapshot<List<Question>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Question> questions = snapshot.data!;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final Question question = questions[index];
              return ListTile(
                title: Text(question.title),
                onTap: () {
                  _editQuestionDialog(context, question);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _confirmDeleteQuestion(context, question.id);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  void _editQuestionDialog(BuildContext context, Question question) {
    TextEditingController questionController = TextEditingController(text: question.title);
    // Initialize option controllers with existing options
    List<TextEditingController> optionControllers = question.options.entries
        .map((entry) => TextEditingController(text: entry.key))
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Question'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: questionController, decoration: InputDecoration(labelText: 'Question')),
              for (int i = 0; i < optionControllers.length; i++)
                TextField(controller: optionControllers[i], decoration: InputDecoration(labelText: 'Option ${i + 1}')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Map<String, dynamic> updatedQuestion = {
                'title': questionController.text,
                'options': Map.fromIterable(optionControllers, key: (optionController) => optionController.text, value: (_) => false),
              };

              _editQuestion(question.id, updatedQuestion);

              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editQuestion(String questionId, Map<String, dynamic> updatedQuestion) {
    // Implement function to edit question in the database
    // Use http.patch or any other method to update the question
  }

  void _confirmDeleteQuestion(BuildContext context, String questionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this question?'),
        actions: [
          TextButton(
            onPressed: () {
              // Call function to delete question
              _deleteQuestion(questionId);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

 void _deleteQuestion(String questionId) async {
  try {
    final response = await http.delete(
      Uri.parse('https://quizapp-787d6-default-rtdb.firebaseio.com/questions/$questionId'), // Replace 'your-api-url' with your actual API URL
    );

    if (response.statusCode == 200) {
      print('Question deleted successfully');
    } else {
      print('Failed to delete question: ${response.statusCode}');
    }
  } catch (error) {
    print('Error deleting question: $error');
  }
}
}
