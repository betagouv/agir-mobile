import 'package:agir/ui/agir_bottom_bar_widget.dart';
import 'package:agir/ui/coach_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  int currentNavigationBarIndex = 0;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/ic-user.png", height: 32, width: 32),
              const SizedBox(
                width: 8,
              ),
              const Text("8 tonnes / ans",
                  style: TextStyle(
                    fontFamily: 'Marianne',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 16,
              ),
              const Text("|",
                  style: TextStyle(
                    fontFamily: 'Marianne',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 16,
              ),
              const Text("304",
                  style: TextStyle(
                    fontFamily: 'Marianne',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black,
                    height: 1.5,
                  )),
              const SizedBox(
                width: 4,
              ),
              Image.asset("assets/ic-leaf.png", height: 32, width: 32),
            ],
          ),
        ),
      ),
      body: displayCurrentScreen(),
      bottomNavigationBar: AgirBottomNavigationBar(
        currentIndex: widget.currentNavigationBarIndex,
        onSelectedItem: (index) {
          setState(() {
            widget.currentNavigationBarIndex = index;
          });
        },
      ),
    );
  }

  Widget displayCurrentScreen() {
    if (widget.currentNavigationBarIndex == 0) {
      return CoachScreen();
    } else {
      return const SizedBox();
    }
  }
}
