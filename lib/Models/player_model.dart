class PlayerModel {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String nationality;
  final String position;
  final int shirtNumber;
  final String currentTeamName;
  final String currentTeamCrest;
  final String contractStart;
  final String contractEnd;
  final List<String> competitions;

  PlayerModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.nationality,
    required this.position,
    required this.shirtNumber,
    required this.currentTeamName,
    required this.currentTeamCrest,
    required this.contractStart,
    required this.contractEnd,
    required this.competitions,
  });

  factory PlayerModel.fromJson(Map<dynamic, dynamic> json) {
   
    List<String> competitionList = [];
    if (json['currentTeam'] != null &&
        json['currentTeam']['runningCompetitions'] != null) {
      competitionList = List<String>.from(
          (json['currentTeam']['runningCompetitions'] as List)
              .map((comp) => comp['name']));
    }

    return PlayerModel(
      id: json['id'],
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      nationality: json['nationality'],
      position: json['position'],
      shirtNumber: json['shirtNumber'],
      currentTeamName: json['currentTeam']['name'],
      currentTeamCrest: json['currentTeam']['crest'],
      contractStart: json['currentTeam']['contract']['start'] ?? 'N/A',
      contractEnd: json['currentTeam']['contract']['until'] ?? 'N/A',
      competitions: competitionList,
    );
  }
}
