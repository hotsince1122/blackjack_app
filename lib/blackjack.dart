import 'package:blackjack/screens/play_screen.dart';
import 'package:blackjack/screens/rules_screen.dart';
import 'package:flutter/material.dart';

import 'package:blackjack/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

final Color darkGreenColor = const Color.fromARGB(255, 8, 85, 44);
final Color goldColor = const Color.fromARGB(255, 208, 170, 70);

class Blackjack extends StatefulWidget {
  const Blackjack({super.key});

  @override
  State<Blackjack> createState() {
    return _BlackjackState();
  }
}

class _BlackjackState extends State<Blackjack> {
  var activeScreen = 'home-screen';

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

  @override
  Widget build(context) {
    Widget screenWidget = HomeScreen(rulesScreen, playScreen);

    if (activeScreen == 'rules-screen') {
      screenWidget = RulesScreen(homeScreen);
    }

    if (activeScreen == 'play-screen') {
      screenWidget = PlayScreen(homeScreen);
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
          color: darkGreenColor,
          height: double.infinity,
          width: double.infinity,
          child: screenWidget,
        ),
      ),
    );
  }
}
