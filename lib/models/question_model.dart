class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

factory Question.fromJson(Map<String, dynamic> json) {
  List<Map<String, dynamic>> optionsList = List<Map<String, dynamic>>.from(json['options']);
  Map<String, bool> options = {};
  optionsList.forEach((option) {
    options[option['text']] = option['isTrue'];
  });
  return Question(
    id: json['id'],
    title: json['title'],
    options: options,
  );
}



  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
