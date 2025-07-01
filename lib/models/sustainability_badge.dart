class SustainabilityBadge {
  final String id;
  final String name;
  final String description;
  final int requiredPoints;
  final String badgeIcon;
  final String color;
  final String level;

  SustainabilityBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredPoints,
    required this.badgeIcon,
    required this.color,
    required this.level,
  });

  factory SustainabilityBadge.fromJson(Map<String, dynamic> json) {
    return SustainabilityBadge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      requiredPoints: json['requiredPoints'],
      badgeIcon: json['badgeIcon'],
      color: json['color'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'requiredPoints': requiredPoints,
      'badgeIcon': badgeIcon,
      'color': color,
      'level': level,
    };
  }
}
