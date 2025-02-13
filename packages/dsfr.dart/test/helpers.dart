import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key, required this.child});

  final Widget child;

  @override
  Widget build(final context) => MaterialApp(home: Scaffold(body: Center(child: child)));
}
