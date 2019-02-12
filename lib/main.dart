import 'package:flutter/material.dart';

import 'package:todo/gradient_background.dart';
import 'package:todo/shadow_image.dart';
import 'package:todo/task_progress_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
        ),
      ),
      home: MyHomePage(title: 'TODO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  var todos = [
    {
      "code_point": 0xe878,
      "progress": 60.0,
      "color": Colors.blue,
    },
    {
      "code_point": 0xe7fd,
      "progress": 40.0,
      "color": Colors.green,
    },
    {
      "code_point": 0xe854,
      "progress": 90.0,
      "color": Colors.orange,
    },
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _counter = 0;
  MaterialColor color = Colors.purple;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      color: color,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 52.0, bottom: 16.0),
              padding: EdgeInsets.only(left: 52.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShadowImage(),
                  Container(
                    margin: EdgeInsets.only(top: 22.0, bottom: 8.0),
                    child: Text(
                      'Hello, Sabin.',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    'Looks like feel good.',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  ),
                  Text(
                    'You have 3 tasks to do today.',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    var currentPage = _pageController.page;
                    print("ScrollNotification = ${_pageController.page}");
                    setState(() {
                      color = widget.todos[currentPage.toInt()]["color"];
                    });
                  }
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 26.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: Icon(
                                IconData(
                                  widget.todos[index]["code_point"],
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: widget.todos[index]["color"],
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '12 Tasks',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Colors.grey[500]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 32.0),
                              child: Text('Work',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(color: Colors.black54)),
                            ),
                            TaskProgressIndicator(
                              color: widget.todos[index]["color"],
                              progress: widget.todos[index]["progress"],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: widget.todos.length,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'New Todo',
          backgroundColor: Colors.white,
          foregroundColor: color,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
