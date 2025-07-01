class SustainablePractice {
  final String id;
  final String name;
  final String description;
  final int points;
  final String icon;
  final String category;

  SustainablePractice({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.icon,
    required this.category,
  });

  factory SustainablePractice.fromJson(Map<String, dynamic> json) {
    return SustainablePractice(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      points: json['points'],
      icon: json['icon'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'icon': icon,
      'category': category,
    };
  }
}
