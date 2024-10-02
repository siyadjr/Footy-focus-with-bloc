import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Screens/Leagues/league_details.dart';
import 'package:footy_focus/constant.dart';

class ChooseLeagues extends StatelessWidget {
  const ChooseLeagues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Leagues'),
      ),
      body: ListView.builder(
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          final league = leagues[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Text(
                league['logo']!,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                league['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(league['country']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
               
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) =>  LeagueDetails(leagueCode:league['code']!,title:league['name']!)));
              },
            ),
          );
        },
      ),
    );
  }
}
