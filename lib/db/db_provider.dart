import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:todo/model/todo_model.dart';
import 'package:todo/model/task_model.dart';

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  var todos = [
    Todo(id: 234, parent: 1, name: "Meet Clients", isCompleted: 0),
    Todo(id: 827, parent: 1, name: "Design Sprint", isCompleted: 0),
    Todo(id: 914, parent: 1, name: "Icon set design for Mobile App", isCompleted: 1),
    Todo(id: 83, parent: 2, name: "20 pushups", isCompleted: 0),
    Todo(id: 3, parent: 2, name: "3 sets squats", isCompleted: 0),
    Todo(id: 23, parent: 2, name: "15 burpees (3 sets)", isCompleted: 0),
  ];

  var tasks = [
    Task(id: 1, name: 'Shopping', color: 8, codePoint: Icons.work.codePoint),
    Task(id: 2, name: 'Workout', color: 7, codePoint: Icons.fitness_center.codePoint),
  ];

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "Todo.db");
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {

    }, onCreate: (Database db, int version) async {
      print("DBProvider:: onCreate()");
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "color INTEGER,"
          "code_point INTEGER"
          ")");
      await db.execute("CREATE TABLE Todo ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "parent INTEGER,"
          "completed INTEGER NOT NULL DEFAULT 0"
          ")");
    });
  }

  insertBulkTask(List<Task> tasks) async {
    final db = await database;
    tasks.forEach((it) async {
      var res = await db.insert("Task", it.toJson());
      print("Task ${it.id} = $res");
    });
  }

  insertBulkTodo(List<Todo> todos) async {
    final db = await database;
    todos.forEach((it) async {
      var res = await db.insert("Todo", it.toJson());
      print("Todo ${it.id} = $res");
    });
  }

  Future<List<Task>> getAllTask() async {
    final db = await database;
    var result = await db.query('Task');
    return result.map((it) => Task.fromJson(it)).toList();
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    var result = await db.query('Todo');
    return result.map((it) => Todo.fromJson(it)).toList();
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return db
        .update('Todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> removeTodo(Todo todo) async {
    final db = await database;
    return db.delete('Todo', where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
