import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionDetailPage extends StatelessWidget {
  const ActionDetailPage({super.key});

  static const name = 'action';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const ActionDetailPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: const [Text('En construction')],
        ),
      );
}
