import 'package:flutter/material.dart';
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

  String sol = '';
  void solut(String value) {
    sol = Postsolution(value)!.round().toString();
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
            '${counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
              child: FloatingActionButton(
            onPressed: () {
              appState.incrementCounter();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ))
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
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var sol = appState.sol;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Equation: ${postEquationGenerator(operators: 3)}'),
          Text(
            'Solution: $sol',
          ),
          Padding(padding: const EdgeInsets.all(8)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Equation',
            ),
            onSubmitted: (String value) {
              appState.solut(value);
            },
          ),
        ],
      ),
    );
  }
}
