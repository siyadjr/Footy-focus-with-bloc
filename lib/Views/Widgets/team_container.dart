import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class TeamContainer extends StatelessWidget {
  const TeamContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 170,
          height: 220,
          decoration: BoxDecoration(
            color: kBoxColor,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                'lib/Assets/Chelsea_FC.svg.png',
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
              'TEAMS',
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
    );
  }
}
