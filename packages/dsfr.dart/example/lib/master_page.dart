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
        appBar: AppBar(
          title: const Text("Système de Design de l'État"),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.pageItems.length,
              itemBuilder: (final BuildContext context, final int index) {
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
            ),
          ),
        ),
        body: widget.pageItems[_currentIndex].pageBuilder.call(context),
      );
}
