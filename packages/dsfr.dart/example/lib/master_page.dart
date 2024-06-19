// ignore_for_file: prefer-extracting-callbacks

import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({required this.pageItems, super.key});

  final List<PageItem> pageItems;

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _currentIndex = 0;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Système de Design de l'État")),
        body: widget.pageItems
            .elementAtOrNull(_currentIndex)
            ?.pageBuilder(context),
        drawer: Drawer(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (final context, final index) {
              final pageItem = widget.pageItems[index];

              return ListTile(
                title: Text(pageItem.title),
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                  Navigator.pop(context);
                },
              );
            },
            itemCount: widget.pageItems.length,
          ),
        ),
      );
}
