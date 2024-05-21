import 'package:flutter/material.dart';

import 'coach_user_widget.dart';
import 'interactions_widget.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [CoachUserWidget(), SizedBox(height: 24), InteractionsWidget()],
          ),
        ),
      ),
    );
  }
}
