import 'package:meta/meta.dart';

class Todo {
  int id;
  String text;
  bool isCompleted;

  Todo({@required this.id, @required this.text, @required this.isCompleted});

  Todo copy({String text, bool isCompleted, int id}) {
    return Todo(
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }
}
