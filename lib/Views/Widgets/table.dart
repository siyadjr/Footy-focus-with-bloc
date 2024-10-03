import 'package:flutter/material.dart';
import 'package:footy_focus/constant.dart';

Widget buildStandingsTab(standings) {
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

  Widget buildTopScorersTab(topScorers) {
    return FutureBuilder<Map<String, dynamic>>(
      future: topScorers,
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
          final scorersData = snapshot.data!;
          final scorers = scorersData['scorers'] as List;
          return ListView.builder(
            itemCount: scorers.length,
            itemBuilder: (context, index) {
              final scorer = scorers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(scorer['team']['crest']),
                    onBackgroundImageError: (_, __) {},
                  ),
                  title: Text(scorer['player']['name']),
                  subtitle: Text(scorer['team']['name']),
                  trailing: Text(
                    '${scorer['goals']} goals',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
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

