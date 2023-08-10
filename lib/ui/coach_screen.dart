import 'package:flutter/material.dart';

import 'coach_user_widget.dart';
import 'interactions_widget.dart';

class CoachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [CoachUserWidget(), const SizedBox(height: 24), InteractionsWidget(), InteractionsWidget()],
          ),
        ),
      ),
    );
  }
}
