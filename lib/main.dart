import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'postfix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'UIL Study App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyAppState extends ChangeNotifier {
  var counter = 0;
  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Counter();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Postfix();
        break;
      case 3:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary),
              child: Text(
                'UIL CS Study App',
                textScaleFactor: 1.75,
              ),
            ),
            ListTile(
                title: const Text('Home'),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text('Binary Search Tree'),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text('Post/Pre Fix Notation'),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text('Miscellaneous'),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Container(
        child: page,
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    super.key,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var counter = appState.counter;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          FloatingActionButton(
            onPressed: () {
              appState.incrementCounter();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class Postfix extends StatefulWidget {
  const Postfix({super.key});

  @override
  State<Postfix> createState() => _PostfixState();
}

class _PostfixState extends State<Postfix> {
  var sol = '';
  String eq = '';
  final myController = TextEditingController();
  Color backgroundColor = Colors.white;
  bool post = true;
  int ops = 4;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Operators'),
            NumberPicker(
                minValue: 1,
                maxValue: 8,
                value: ops,
                haptics: true,
                onChanged: (value) => setState(() => ops = value)),
            FlutterSwitch(
                width: 125,
                height: 75.0,
                toggleSize: 60.0,
                value: post,
                activeIcon: Text("PostFix"),
                inactiveIcon: Text("PreFix"),
                onToggle: (val) {
                  setState(() {
                    post = val;
                  });
                }),
            Padding(padding: const EdgeInsets.all(30)),
            Text(
              'Equation:\n$eq',
              textScaleFactor: 1.75,
            ),
            Padding(padding: const EdgeInsets.all(8)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Answer',
              ),
              controller: myController,
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        backgroundColor = Colors.white;
                        sol = '';
                        myController.text = '';
                        if (post) {
                          eq = postEquationGenerator(operators: ops);
                        } else {
                          eq = preEquationGenerator(operators: ops);
                        }
                      });
                    },
                    child: Text('Generate')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (post) {
                          sol = Postsolution(eq)!.round().toString();
                          backgroundColor = Colors.white;
                        } else {
                          sol = Presolution(eq)!.round().toString();
                          backgroundColor = Colors.white;
                        }
                      });
                    },
                    child: Text('Solution')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (post) {
                          if (myController.text ==
                              Postsolution(eq)!.round().toString()) {
                            backgroundColor = Colors.green;
                          } else {
                            backgroundColor = Colors.red;
                          }
                        } else {
                          if (myController.text ==
                              Presolution(eq)!.round().toString()) {
                            backgroundColor = Colors.green;
                          } else {
                            backgroundColor = Colors.red;
                          }
                        }
                      });
                    },
                    child: Text('Check Answer')),
              ],
            ),
            Text(
              'Solution: $sol',
              textScaleFactor: 1.25,
            ),
            Padding(padding: const EdgeInsets.all(100))
          ],
        ),
      ),
    );
  }
}
