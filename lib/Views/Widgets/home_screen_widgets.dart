import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Widgets/player_container.dart';
import 'package:footy_focus/Views/Widgets/team_container.dart';
import 'package:footy_focus/constant.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildAppBar() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Text(
      'Footy Focus',
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: kPrimaryTextColor, // Deep Navy
      ),
    ),
  );
}

Widget buildMainContent() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Explore',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kPrimaryTextColor, // Deep Navy
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: const PlayerContainer(),
            ),
            GestureDetector(
              onTap: () {},
              child: const TeamContainer(),
            ),
          ],
        ),
      ],
    ),
  );
}
