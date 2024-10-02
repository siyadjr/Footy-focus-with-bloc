import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Screens/Leagues/choose_leagues.dart';
import 'package:footy_focus/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: kSecondBoxColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(9),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Access',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAccessButton(
                    Icons.emoji_events, 'Leagues', Colors.yellow, () {
                  // Add navigation or function call for Leagues
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const ChooseLeagues()));
                  print('Leagues button pressed');
                }),
                _buildQuickAccessButton(
                    Icons.calendar_today, 'Fixtures', Colors.blue, () {
                  // Add navigation or function call for Fixtures
                  print('Fixtures button pressed');
                }),
                _buildQuickAccessButton(Icons.bar_chart, 'Stats', Colors.green,
                    () {
                  // Add navigation or function call for Stats
                  print('Stats button pressed');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      splashColor: color.withOpacity(0.3), // Ripple effect color
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1), // Semi-transparent
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: kPrimaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
