import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_exercize/my_tables.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MOOR EXERCISE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<String>> getFuture() async {
    return Future.delayed(const Duration(seconds: 1), () => ['a', 'b']);
  }

  Stream<List<String>> getStream() {
    return Future.delayed(const Duration(seconds: 1), () => ['a', 'b']).asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyDatabase().addTodo(
            TodosCompanion(
              title: Value('First Todo'),
              content: Value('content'),
            ),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<Todo>>(
            //initialData: ['1', '2'],
            //future: getFuture(),
            future: MyDatabase().allTodoEntries,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('no data');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Todo _todo = snapshot.data[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text('${_todo.id} '),
                          Text('${_todo.title}'),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
