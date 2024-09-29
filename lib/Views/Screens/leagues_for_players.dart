import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Screens/teams_list.dart';
import 'package:footy_focus/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaguesForPlayers extends StatefulWidget {
  const LeaguesForPlayers({super.key});

  @override
  _LeaguesForPlayersState createState() => _LeaguesForPlayersState();
}

class _LeaguesForPlayersState extends State<LeaguesForPlayers> {
  final List<Map<String, String>> leagues = [
    {
      "name": "Premier League",
      "country": "England",
      "logo": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
      "id": " 2021"
    },
    {"name": "La Liga", "country": "Spain", "logo": "🇪🇸", "id": "2014"},
    {"name": "Bundesliga", "country": "Germany", "logo": "🇩🇪", "id": "2002"},
    {"name": "Serie A", "country": "Italy", "logo": "🇮🇹", "id": "2019"},
    {"name": "Ligue 1", "country": "France", "logo": "🇫🇷", "id": "2015"},
    {
      "name": "Eredivisie",
      "country": "Netherlands",
      "logo": "🇳🇱",
      "id": "2003"
    },
    {
      "name": "Primeira Liga",
      "country": "Portugal",
      "logo": "🇵🇹",
      "id": "2017"
    },
    {
      "name": "Scottish Premiership",
      "country": "Scotland",
      "logo": "🏴󠁧󠁢󠁳󠁣󠁴󠁿",
      "id": "2084"
    },
    {
      "name": "Belgian Pro League",
      "country": "Belgium",
      "logo": "🇧🇪",
      "id": "2009"
    },
    {
      "name": "Russian Premier League",
      "country": "Russia",
      "logo": "🇷🇺",
      "id": "2128"
    },
  ];

  List<Map<String, String>> filteredLeagues = [];

  @override
  void initState() {
    super.initState();
    filteredLeagues = leagues;
  }

  void _filterLeagues(String query) {
    setState(() {
      filteredLeagues = leagues
          .where((league) =>
              league['name']!.toLowerCase().contains(query.toLowerCase()) ||
              league['country']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        title: Text('Football Leagues', style: GoogleFonts.poppins()),
        backgroundColor: kBackGroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterLeagues,
              decoration: InputDecoration(
                hintText: 'Search Players...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          filteredLeagues.isEmpty
              ? const Center(
                  child: Text('No Leagues'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredLeagues.length,
                    itemBuilder: (context, index) {
                      final league = filteredLeagues[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: Text(
                            league['logo']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(
                            league['name']!,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            league['country']!,
                            style: GoogleFonts.poppins(),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => TeamsList(
                                          leagueId: league['id']!,
                                        )));
                          },
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
