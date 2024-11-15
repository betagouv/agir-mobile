import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:flutter/material.dart';

class FnvScaffold extends StatelessWidget {
  const FnvScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.drawer,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: appBar,
        body: body,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: FnvColors.accueilFond,
      );
}
