import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final context) =>
      MaterialApp(home: Scaffold(body: Center(child: child)));
}
