import 'package:flutter/material.dart';
import 'package:footy_focus/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeagueDetails extends StatefulWidget {
  final String leagueCode;
  final String title;

  const LeagueDetails({Key? key, required this.leagueCode, required this.title})
      : super(key: key);

  @override
  _LeagueDetailsState createState() => _LeagueDetailsState();
}

class _LeagueDetailsState extends State<LeagueDetails>
    with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> standings;
  late TabController _tabController;
  final List<String> _tabs = ['Standings', 'Top Scorers'];

  @override
  void initState() {
    super.initState();
    standings = fetchStandings(widget.leagueCode);
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchStandings(String leagueCode) async {
    final response = await http.get(
      Uri.parse(
          'https://api.football-data.org/v4/competitions/$leagueCode/standings'),
      headers: {"X-Auth-Token": apiKey},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load standings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Details'),
        backgroundColor: kBackGroundColor,
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((String name) => Tab(text: name)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStandingsTab(),
          _buildTopScorersTab(),
        ],
      ),
    );
  }

  Widget _buildStandingsTab() {
    return FutureBuilder<Map<String, dynamic>>(
      future: standings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red[800], fontSize: 18),
            ),
          );
        } else if (snapshot.hasData) {
          final standingsData = snapshot.data!;
          return ListView.builder(
            itemCount: standingsData['standings'].length,
            itemBuilder: (context, index) {
              final leagueStandings = standingsData['standings'][index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        color: kBackGroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Text(
                        leagueStandings['stage'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20,
                        headingRowColor:
                            WidgetStateProperty.all(Colors.grey[200]),
                        columns: const [
                          DataColumn(
                              label: Text('Pos',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Team',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('P',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('W',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('D',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('L',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('GF',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('GA',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('GD',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Pts',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: leagueStandings['table'].map<DataRow>((team) {
                          return DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (team['position'] <= 4)
                                  return Colors.blue[50];
                                if (team['position'] >=
                                    leagueStandings['table'].length - 3)
                                  return Colors.red[50];
                                return null;
                              },
                            ),
                            cells: [
                              DataCell(Text(team['position'].toString())),
                              DataCell(
                                Row(
                                  children: [
                                    Image.network(
                                      team['team']['crest'],
                                      width: 24,
                                      height: 24,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.sports_soccer),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(team['team']['name']),
                                  ],
                                ),
                              ),
                              DataCell(Text(team['playedGames'].toString())),
                              DataCell(Text(team['won'].toString())),
                              DataCell(Text(team['draw'].toString())),
                              DataCell(Text(team['lost'].toString())),
                              DataCell(Text(team['goalsFor'].toString())),
                              DataCell(Text(team['goalsAgainst'].toString())),
                              DataCell(Text(team['goalDifference'].toString())),
                              DataCell(
                                Text(
                                  team['points'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildTopScorersTab() {
  
    return const Center(
      child: Text('Top Scorers Coming Soon!'),
    );
  }
}
