import 'dart:math';

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
            TfAsyncProgressElevatedButton(
              action: connectToServer,
              undoAction: connectToServer,
              actionInitButtonChild: const Text('Connect'),
              actionInProgressButtonChild: const Text('Wait'),
              actionCompleteButtonChild: const Text('Disconnect'),
              size: const Size(120, 40),
              actionInitButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              actionInProgressButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              actionDoneButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onActionErrored: (e) {
                print('Error: $e');
              },
              onUndoActionErrored: (e) {
                print('Error: $e');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> connectToServer() async {
    final task = Future.delayed(const Duration(seconds: 2));
    await task;
    final randInt = Random().nextInt(3);
    if (randInt == 0) {
      throw Exception('Manually generated error for testing');
    }
  }
}
