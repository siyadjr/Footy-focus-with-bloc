import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Models/player_model.dart';
import 'package:footy_focus/constant.dart';

class PlayerDetails extends StatefulWidget {
  final int playerId;

  const PlayerDetails({Key? key, required this.playerId}) : super(key: key);

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  late Future<PlayerModel?> _playerStatsFuture;

  @override
  void initState() {
    super.initState();
    _playerStatsFuture = FootballApi().getPlayerStats(widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: FutureBuilder<PlayerModel?>(
        future: _playerStatsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No player data found.'));
          }

          final player = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(player.name),
                  background: Image.network(
                    'https://via.placeholder.com/300',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person,
                          size: 100, color: Colors.white);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard('Personal Information', [
                        _buildInfoRow('Full Name', player.name),
                        _buildInfoRow('Date of Birth', player.dateOfBirth),
                        _buildInfoRow('Nationality', player.nationality),
                      ]),
                      const SizedBox(height: 16),
                      _buildInfoCard('Professional Information', [
                        _buildInfoRow('Position', player.position),
                        _buildInfoRow('Shirt Number',
                            player.shirtNumber.toString() ?? 'N/A'),
                      ]),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatistics(Map<String, dynamic> stats) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Season Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildStatRow(
                'Appearances', stats['appearances']?.toString() ?? '0'),
            _buildStatRow('Goals', stats['goals']?.toString() ?? '0'),
            _buildStatRow('Assists', stats['assists']?.toString() ?? '0'),
            _buildStatRow(
                'Yellow Cards', stats['yellowCards']?.toString() ?? '0'),
            _buildStatRow('Red Cards', stats['redCards']?.toString() ?? '0'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
