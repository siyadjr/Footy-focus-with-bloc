import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/TeamsBloc/teams_bloc_bloc.dart';
import 'package:footy_focus/Models/team_model.dart';
import 'package:footy_focus/Views/Screens/team_players.dart';

class TeamsList extends StatelessWidget {
  final String leagueId;

  const TeamsList({
    super.key,
    required this.leagueId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsBlocBloc()..add(LoadTeams(leagueId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teams'),
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search teams...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (query) {
                  context.read<TeamsBlocBloc>().add(FilterTeams(query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TeamsBlocBloc, TeamsBlocState>(
                builder: (context, state) {
                  if (state is TeamsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TeamsError) {
                    return Center(child: Text(state.message));
                  } else if (state is TeamsLoaded || state is TeamsFiltered) {
                    final teams = state is TeamsLoaded
                        ? state.teams
                        : (state as TeamsFiltered).filteredTeams;

                    return teams.isEmpty
                        ? const Center(child: Text('No teams found'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: teams.length,
                            itemBuilder: (context, index) {
                              final team = teams[index];
                              return TeamCard(team: team);
                            },
                          );
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamModel team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => TeamPlayers(teamId: team.id)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: team.crest != null
                  ? Image.network(
                      team.crest!,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.shield, size: 60);
                      },
                    )
                  : const Icon(Icons.shield, size: 60),
            ),
            const SizedBox(height: 16),
            Text(
              team.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              team.country,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
