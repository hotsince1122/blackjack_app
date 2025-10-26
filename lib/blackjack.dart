import 'package:blackjack/screens/play_screen.dart';
import 'package:blackjack/screens/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/screens/preferences_screen.dart';
import 'package:blackjack/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackjack/widgets/betting_modal_sheet.dart';

final Color darkGreenColor = const Color.fromARGB(255, 8, 85, 44);
final Color goldColor = const Color.fromARGB(255, 208, 170, 70);

int initialBalance = 500;

class Blackjack extends StatefulWidget {
  const Blackjack({super.key});

  @override
  State<Blackjack> createState() {
    return _BlackjackState();
  }
}

class _BlackjackState extends State<Blackjack> {
  var activeScreen = 'home-screen';
  Color backgroundColor = darkGreenColor;

  void rulesScreen() {
    setState(() {
      activeScreen = 'rules-screen';
    });
  }

  void playScreen() {
    setState(() {
      activeScreen = 'play-screen';
    });
  }

  void homeScreen() {
    setState(() {
      activeScreen = 'home-screen';
    });
  }

  void preferencesScreen() {
    setState(() {
      activeScreen = 'preferences-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = HomeScreen(rulesScreen, playScreen, preferencesScreen);
    backgroundColor = darkGreenColor;

    if (activeScreen == 'rules-screen') {
      screenWidget = RulesScreen(homeScreen);
    }

    if (activeScreen == 'play-screen') {
      screenWidget = PlayScreen(homeScreen, initialBalance);
    }

    if (activeScreen == 'preferences-screen') {
      screenWidget = PreferencesScreen(homeScreen, initialBalance.toDouble());
      backgroundColor = fancyLightBrown;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: GoogleFonts.merriweather().fontFamily,
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: Scaffold(
        body: Container(
          color: backgroundColor,
          height: double.infinity,
          width: double.infinity,
          child: screenWidget,
        ),
      ),
    );
  }
}
