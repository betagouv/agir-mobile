import 'package:flutter/material.dart';

class PageItem {
  const PageItem({required this.title, required this.pageBuilder});

  final String title;
  final WidgetBuilder pageBuilder;
}
