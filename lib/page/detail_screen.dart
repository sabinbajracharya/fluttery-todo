import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:todo/model/todo_list_model.dart';

import 'package:todo/task_progress_indicator.dart';
import 'package:todo/component/todo_badge.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/todo_model.dart';

class DetailScreen extends StatefulWidget {
  final double progress;
  final Color color;
  final int codePoint;
  final int id;
  final HeroId heroIds;

  DetailScreen({
    @required this.codePoint,
    @required this.color,
    @required this.progress,
    @required this.id,
    @required this.heroIds,
  });

  @override
  State<StatefulWidget> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 280),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);

    setState(() => {});
  }

  // getContainer(bool isCompleted, {Widget child}) {
  //   if (isCompleted) {
  //     return Container(
  //       padding: EdgeInsets.only(left: 22.0, right: 22.0),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //           stops: [0.4, 0.6, 1],
  //           colors: <Color>[
  //             Colors.grey.shade100,
  //             Colors.grey.shade50,
  //             Colors.white,
  //           ],
  //         ),
  //       ),
  //       child: child,
  //     );
  //   } else {
  //     return Container(
  //       padding: EdgeInsets.only(left: 22.0, right: 22.0),
  //       child: child,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        return Theme(
          data: ThemeData(primarySwatch: widget.color),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black26),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TodoBadge(
                        color: widget.color,
                        codePoint: widget.codePoint,
                        id: widget.heroIds.codePointId,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4.0),
                        child: Hero(
                          tag: widget.heroIds.remainingTaskId,
                          child: Text(
                            '12 Tasks',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      Container(
                        child: Hero(
                          tag: widget.heroIds.titleId,
                          child: Text('Work',
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.black54)),
                        ),
                      ),
                      Spacer(),
                      Hero(
                        tag: widget.heroIds.progressId,
                        child: TaskProgressIndicator(
                          color: widget.color,
                          progress: widget.progress,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: SlideTransition(
                      position: _animation,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          var todo = model.todos[index];
                          return Container(
                            padding: EdgeInsets.only(left: 22.0, right: 22.0),
                            child: ListTile(
                              onTap: () => model.updateTodo(
                                  todo.copy(isCompleted: !todo.isCompleted)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8.0),
                              leading: Checkbox(
                                  onChanged: (value) => model.updateTodo(
                                      todo.copy(isCompleted: value)),
                                  value: todo.isCompleted),
                              trailing: IconButton(
                                icon: Icon(Icons.delete_outline),
                                onPressed: () => model.removeTodo(todo),
                              ),
                              title: Text(
                                todo.text,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: todo.isCompleted
                                      ? widget.color
                                      : Colors.black54,
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: model.todos.length,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
