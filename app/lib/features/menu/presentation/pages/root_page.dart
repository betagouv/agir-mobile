import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/menu/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    this.title,
    this.appBarBottom,
    required this.body,
  });

  final Widget? title;
  final Widget? appBarBottom;
  final Widget body;

  @override
  Widget build(final context) => FnvScaffold(
        appBar: FnvAppBar(title: title, bottom: appBarBottom),
        body: body,
        drawer: const Menu(),
      );
}
