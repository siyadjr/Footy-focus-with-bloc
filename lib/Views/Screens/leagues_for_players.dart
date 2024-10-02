import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/bloc/league_for_players_bloc.dart';
import 'package:footy_focus/Views/Screens/teams_list.dart';
import 'package:footy_focus/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaguesForPlayers extends StatelessWidget {
  const LeaguesForPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LeagueForPlayersBloc>().add(LoadLeagues());

    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        title: Text('Football Leagues', style: GoogleFonts.poppins()),
        backgroundColor: kBackGroundColor,
      ),
      body: BlocBuilder<LeagueForPlayersBloc, LeagueForPlayersState>(
        builder: (context, state) {
          if (state is LeagueForPlayersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LeagueLoaded || state is LeaguesFiltered) {
            final leagues = state is LeagueLoaded
                ? state.leagues
                : (state as LeaguesFiltered).filteredLeagues;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (query) {
                      context
                          .read<LeagueForPlayersBloc>()
                          .add(FilterLeagues(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Leagues...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                leagues.isEmpty
                    ? const Center(child: Text('No Leagues'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: leagues.length,
                          itemBuilder: (context, index) {
                            final league = leagues[index];
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
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
