import 'package:flutter/material.dart';
import 'package:tf_async_progress_button/tf_async_progress_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TfAsyncProgressButton(
              width: 120,
              height: 40,
              actionInitWidget: Text('Connect'),
              actionCompletedWidget: Text('Disconnect'),
              buttonStyleInitial: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              buttonStyleOnActionComplete: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              actionCallback: () async {
                await connectToServer();
              },
              actionReversedCallback: () async {
                await connectToServer();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> connectToServer() async {
    final task = Future.delayed(Duration(seconds: 2));
    await task;
  }
}
