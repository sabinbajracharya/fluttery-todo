import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:todo/model/todo_model.dart';

class TodoListModel extends Model {
  List<Todo> get todos => _todos.toList();
  List<Todo> _todos = [];

  static TodoListModel of(BuildContext context) =>
      ScopedModel.of<TodoListModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    // update data for every subscriber, especially for the first one
    loadTodos();
  }

  void loadTodos() {
    var todos = [
      Todo(id: 234, text: "Meet Clients", isCompleted: false),
      Todo(id: 827, text: "Design Sprint", isCompleted: false),
      Todo(id: 914, text: "Icon set design for Mobile App", isCompleted: true),
    ];
    _todos = todos;
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((it) => it.id == todo.id);
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
  }
}
