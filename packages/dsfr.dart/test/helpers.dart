import 'package:flutter/material.dart';

MaterialApp app(final Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

class App extends StatelessWidget {
  const App({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) =>
      MaterialApp(home: Scaffold(body: Center(child: child)));
}
