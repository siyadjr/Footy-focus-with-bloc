import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Latest Results',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const Divider(height: 1),
          _buildMatchResult('Chelsea', 2, 'Manchester United', 1),
          _buildMatchResult('Real Madrid', 3, 'Barcelona', 2),
          _buildMatchResult('Juventus', 1, 'Inter Milan', 1),
          _buildMatchResult('Bayern Munich', 4, 'Dortmund', 1),
          _buildMatchResult('PSG', 5, 'Marseille', 2),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
               
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDefaultIconLightColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'All Results',
                  style: GoogleFonts.poppins(
                    color: kPrimaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchResult(String team1, int score1, String team2, int score2) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              team1,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$score1 - $score2',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              team2,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
