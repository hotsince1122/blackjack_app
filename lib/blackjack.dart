import 'package:blackjack/screens/play_screen.dart';
import 'package:blackjack/screens/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/screens/preferences_screen.dart';
import 'package:blackjack/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackjack/widgets/betting_modal_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color darkGreenColor = const Color.fromARGB(255, 8, 85, 44);
final Color goldColor = const Color.fromARGB(255, 208, 170, 70);

class GameData {
  double balance;
  
  GameData(this.balance);

  Future<void> saveBalance (double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }
}

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

  GameData gameData = GameData(1000);

  Future<void> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    double? savedBalance = prefs.getDouble('balance');

    if(savedBalance != null) {
      setState(() {
        gameData.balance = savedBalance;
      });
    }
    else {
      gameData.balance = 1000.0;
    }
  }

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
  void initState()
  {
    super.initState();
    loadBalance();
  }


  @override
  Widget build(context) {
    Widget screenWidget = HomeScreen(rulesScreen, playScreen, preferencesScreen);
    backgroundColor = darkGreenColor;

    if (activeScreen == 'rules-screen') {
      screenWidget = RulesScreen(homeScreen);
    }

    if (activeScreen == 'play-screen') {
      screenWidget = PlayScreen(homeScreen, gameData);
    }

    if (activeScreen == 'preferences-screen') {
      screenWidget = PreferencesScreen(homeScreen, gameData);
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
