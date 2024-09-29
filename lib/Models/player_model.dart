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
  });

 
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
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
    );
  }
}
