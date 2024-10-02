import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Screens/PlayerScreens/leagues_for_players.dart';
import 'package:footy_focus/constant.dart';
import 'package:footy_focus/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sharedPrefFunction();
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const LeaguesForPlayers()));
      },
      child: Stack(
        children: [
          Container(
            width: 170,
            height: 220,
            decoration: BoxDecoration(
              color: kBoxColor, // Ocean Blue
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage(
                  'lib/Assets/download (2).jpeg',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'PLAYERS',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sharedPrefFunction() async {
    final sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool('player', true);
  }
}
