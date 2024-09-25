import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/menu/presentation/widgets/menu.dart';
import 'package:app/features/menu/presentation/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({this.title, required this.body, super.key});

  final Widget? title;
  final Widget body;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: FnvAppBar(leading: const MenuButton(), title: title),
        body: body,
        drawer: const Menu(),
        backgroundColor: FnvColors.accueilFond,
      );
}
