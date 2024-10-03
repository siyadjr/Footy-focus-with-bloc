import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Widgets/table.dart';
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
  late Future<Map<String, dynamic>> topScorers;
  late TabController _tabController;
  final List<String> _tabs = ['Standings', 'Top Scorers'];

  @override
  void initState() {
    super.initState();
    standings = fetchStandings(widget.leagueCode);
    topScorers = fetchTopScorers(widget.leagueCode);
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

  Future<Map<String, dynamic>> fetchTopScorers(String leagueCode) async {
    final response = await http.get(
      Uri.parse(
          'https://api.football-data.org/v4/competitions/$leagueCode/scorers'),
      headers: {"X-Auth-Token": apiKey},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load top scorers');
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
          buildStandingsTab(standings),
          buildTopScorersTab(topScorers),
        ],
      ),
    );
  }
}
