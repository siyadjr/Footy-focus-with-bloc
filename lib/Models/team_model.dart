class TeamModel {
  final int id;
  final String name;
  final String country;
  final String crest;
  final int founded;
  final String venue;
  final String? address;     // Optional field
  final String? phone;       // Optional field
  final String? website;     // Optional field
  final String? email;       // Optional field
  final String? clubColors;  // Optional field
  final List<dynamic>? external;  // Additional external data if available

  TeamModel({
    required this.id,
    required this.name,
    required this.country,
    required this.crest,
    required this.founded,
    required this.venue,
    this.address,
    this.phone,
    this.website,
    this.email,
    this.clubColors,
    this.external,
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
      address: json['address'] as String?, // Optional fields
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      clubColors: json['clubColors'] as String?,
      external: json.containsKey('external') ? json['external'] as List<dynamic> : null, // Additional data if available
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
      'address': address,
      'phone': phone,
      'website': website,
      'email': email,
      'clubColors': clubColors,
      'external': external,
    };
  }
}
