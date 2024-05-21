import 'package:agir/ui/agir_bottom_bar_widget.dart';
import 'package:agir/ui/coach_screen.dart';
import 'package:agir/ui/theme/text_styles/agir_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  int currentNavigationBarIndex = 0;

  LandingPage({super.key});

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
              SvgPicture.asset("assets/ic-user.svg", height: 32, width: 32),
              const SizedBox(
                width: 8,
              ),
              Text("8 tonnes / ans",
                  style: AgirTextStyles.Agir20BlackTextStyle()),
              const SizedBox(
                width: 16,
              ),
              Text("|",
                  style: AgirTextStyles.Agir20BlackTextStyle()),
              const SizedBox(
                width: 16,
              ),
              Text("304",
                  style: AgirTextStyles.Agir20BlackBoldTextStyle()),
              const SizedBox(
                width: 4,
              ),
              SvgPicture.asset("assets/ic-leaf.svg", height: 32, width: 32),
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
      return const CoachScreen();
    } else {
      return const SizedBox();
    }
  }
}
