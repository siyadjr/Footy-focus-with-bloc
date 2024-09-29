import 'package:flutter/material.dart';
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
                _buildQuickAccessItem(
                    Icons.emoji_events, 'Leagues', Colors.yellow),
                _buildQuickAccessItem(
                    Icons.calendar_today, 'Fixtures', Colors.blue),
                _buildQuickAccessItem(Icons.bar_chart, 'Stats', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label, color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1), // Semi-transparent
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon, color: color, size: 30), // Cool Blue
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: kPrimaryTextColor, // Deep Navy
          ),
        ),
      ],
    );
  }
}
