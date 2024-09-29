class TeamModel {
  final int id;
  final String name;
  final String country;
  final String crest;
  final int founded;
  final String venue;

  TeamModel({
    required this.id,
    required this.name,
    required this.country,
    required this.crest,
    required this.founded,
    required this.venue,
  });

  // Factory constructor to create a TeamModel from a JSON map
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['area']['name'] as String, // 'area' for country details
      crest: json['crest'] as String, // 'crest' for logo/crest URL
      founded: json['founded'] as int, // Year team was founded
      venue: json['venue'] as String, // Team's stadium/venue name
    );
  }

  // Convert the TeamModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'crest': crest,
      'founded': founded,
      'venue': venue,
    };
  }
}
