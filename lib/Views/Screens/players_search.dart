import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';

import 'package:google_fonts/google_fonts.dart';

class PlayerSearch extends StatefulWidget {
  const PlayerSearch({super.key});

  @override
  _PlayerSearchState createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {
  final FootballApi footballApi = FootballApi();
  List<Map<String, dynamic>> players = [];
  List<Map<String, dynamic>> filteredPlayers = [];

  void _filterPlayers(String query) async {
    if (query.isNotEmpty) {
      try {
        final fetchedPlayers = await footballApi.searchPlayers(query);
        setState(() {
          players = fetchedPlayers;
          filteredPlayers = fetchedPlayers;
        });
      } catch (e) {
        // Handle the error accordingly
        print('Error fetching players: $e');
      }
    } else {
      setState(() {
        filteredPlayers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Players', style: GoogleFonts.poppins()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterPlayers,
              decoration: InputDecoration(
                hintText: 'Search Players...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = filteredPlayers[index];
                return ListTile(
                  title: Text(player['name'] ?? 'Unknown Player'),
                  subtitle: Text(player['position'] ?? 'Position Unknown'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
