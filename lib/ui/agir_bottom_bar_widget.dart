import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AgirBottomNavigationBar extends StatefulWidget {
  int currentIndex;

  final ValueChanged<int> onSelectedItem;

  AgirBottomNavigationBar({super.key, required this.onSelectedItem, this.currentIndex = 0});

  @override
  State<AgirBottomNavigationBar> createState() =>
      _AgirBottomNavigationBarState();
}

class _AgirBottomNavigationBarState extends State<AgirBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        buildNavigationBarItem("assets/ic-home.png", 0, "Agir !"),
        buildNavigationBarItem("assets/ic-dashboard.png", 1, "Tableau de Bord"),
        buildNavigationBarItem("assets/ic-aide.png", 2, "Mes Aides"),
        buildNavigationBarItem("assets/ic-communaute.png", 3, "Communauté"),
      ]),
    );
  }

  Widget buildNavigationBarItem(String imageName, int index, String label) {
    return InkWell(
      child: getItem(imageName,index,label),
      onTap: () {
        setState(() {
          widget.currentIndex = index;
        });
        widget.onSelectedItem(index);
      },
    );

  }

  Widget getItem(String imageName, int index, String label) {
    if (index == widget.currentIndex) {
      return Row(
        children: [Image.asset(imageName), Text(label)],
      );
    } else {
      return Image.asset(imageName);
    }
  }
}
