import 'package:flutter/material.dart';

void main() {
  runApp(
    const XylophoneApp(),
  );
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Xylophone'),
      ),
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            print('i got clicked!');
          },
          child: Text('i got clicked'),
        ),
      ),
    ));
  }
}
