import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:todo/scopedmodel/todo_list_model.dart';
import 'package:todo/gradient_background.dart';
import 'package:todo/task_progress_indicator.dart';
import 'package:todo/page/add_task_screen.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/route/scale_route.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/utils/datetime_utils.dart';
import 'package:todo/page/detail_screen.dart';
import 'package:todo/component/todo_badge.dart';
import 'package:todo/page/privacy_policy.dart';
import 'package:todo/model/data/choice_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
        ),
      ),
      home: MyHomePage(title: ''),
    );

    return ScopedModel<TodoListModel>(
      model: TodoListModel(),
      child: app,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  HeroId _generateHeroIds(Task task) {
    return HeroId(
      codePointId: 'code_point_id_${task.id}',
      progressId: 'progress_id_${task.id}',
      titleId: 'title_id_${task.id}',
      remainingTaskId: 'remaining_task_id_${task.id}',
    );
  }

  String currentDay(BuildContext context) {

    return DateTimeUtils.currentDay;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
        builder: (BuildContext context, Widget child, TodoListModel model) {
      var _isLoading = model.isLoading;
      var _tasks = model.tasks;
      var _todos = model.todos;
      var backgroundColor = _tasks.isEmpty || _tasks.length == _currentPageIndex
          ? Colors.blueGrey
          : ColorUtils.getColorFrom(id: _tasks[_currentPageIndex].color);
      if (!_isLoading) {
        // move the animation value towards upperbound only when loading is complete
        _controller.forward();
      }
      return GradientBackground(
        color: backgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: [
              PopupMenuButton<Choice>(
                onSelected: (choice) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PrivacyPolicyScreen()));
                },
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : FadeTransition(
                  opacity: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0.0, left: 56.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ShadowImage(),
                            Container(
                              // margin: EdgeInsets.only(top: 22.0),
                              child: Text(
                                '${widget.currentDay(context)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Text(
                              '${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth}',
                              style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(height: 16.0),
                            Text(
                              'You have ${_todos.where((todo) => todo.isCompleted == 0).length} tasks to complete',
                              style: Theme.of(context).textTheme.body1.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(
                              height: 16.0,
                            )
                            // Container(
                            //   margin: EdgeInsets.only(top: 42.0),
                            //   child: Text(
                            //     'TODAY : FEBURARY 13, 2019',
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .subtitle
                            //         .copyWith(color: Colors.white.withOpacity(0.8)),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        key: _backdropKey,
                        flex: 1,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              print(
                                  "ScrollNotification = ${_pageController.page}");
                              var currentPage =
                                  _pageController.page.round().toInt();
                              if (_currentPageIndex != currentPage) {
                                setState(() => _currentPageIndex = currentPage);
                              }
                            }
                          },
                          child: PageView.builder(
                            controller: _pageController,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == _tasks.length) {
                                return AddPageCard(
                                  color: Colors.blueGrey,
                                );
                              } else {
                                return TaskCard(
                                  backdropKey: _backdropKey,
                                  color: ColorUtils.getColorFrom(
                                      id: _tasks[index].color),
                                  getHeroIds: widget._generateHeroIds,
                                  getTaskCompletionPercent:
                                      model.getTaskCompletionPercent,
                                  getTotalTodos: model.getTotalTodosFrom,
                                  task: _tasks[index],
                                );
                              }
                            },
                            itemCount: _tasks.length + 1,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 32.0),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AddPageCard extends StatelessWidget {
  final Color color;

  const AddPageCard({Key key, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 52.0,
                  color: color,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  'Add Category',
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef TaskGetter<T, V> = V Function(T value);

class TaskCard extends StatelessWidget {
  final GlobalKey backdropKey;
  final Task task;
  final Color color;

  final TaskGetter<Task, int> getTotalTodos;
  final TaskGetter<Task, HeroId> getHeroIds;
  final TaskGetter<Task, int> getTaskCompletionPercent;

  TaskCard({
    @required this.backdropKey,
    @required this.color,
    @required this.task,
    @required this.getTotalTodos,
    @required this.getHeroIds,
    @required this.getTaskCompletionPercent,
  });

  @override
  Widget build(BuildContext context) {
    var heroIds = getHeroIds(task);
    return GestureDetector(
      onTap: () {
        final RenderBox renderBox =
            backdropKey.currentContext.findRenderObject();
        var backDropHeight = renderBox.size.height;
        var bottomOffset = 60.0;
        var horizontalOffset = 52.0;
        var topOffset = MediaQuery.of(context).size.height - backDropHeight;

        var rect = RelativeRect.fromLTRB(
            horizontalOffset, topOffset, horizontalOffset, bottomOffset);
        Navigator.push(
          context,
          ScaleRoute(
            rect: rect,
            widget: DetailScreen(
              taskId: task.id,
              heroIds: heroIds,
            ),
          ),
          // MaterialPageRoute(
          //   builder: (context) => DetailScreen(
          //         taskId: task.id,
          //         heroIds: heroIds,
          //       ),
          // ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TodoBadge(
                id: heroIds.codePointId,
                codePoint: task.codePoint,
                color: ColorUtils.getColorFrom(
                  id: task.color,
                ),
              ),
              Spacer(
                flex: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4.0),
                child: Hero(
                  tag: heroIds.remainingTaskId,
                  child: Text(
                    "${getTotalTodos(task)} Task",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.grey[500]),
                  ),
                ),
              ),
              Container(
                child: Hero(
                  tag: heroIds.titleId,
                  child: Text(task.name,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.black54)),
                ),
              ),
              Spacer(),
              Hero(
                tag: heroIds.progressId,
                child: TaskProgressIndicator(
                  color: color,
                  progress: getTaskCompletionPercent(task),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
