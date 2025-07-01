class Farmer {
  // Your existing fields...

  final List<String> selectedPractices;
  final int sustainabilityScore;
  final List<String> earnedBadges;
  final DateTime? lastUpdated;

  Farmer({
    // ...existing params
    this.selectedPractices = const [],
    this.sustainabilityScore = 0,
    this.earnedBadges = const [],
    this.lastUpdated,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      // ...existing fields
      selectedPractices: List<String>.from(json['selectedPractices'] ?? []),
      sustainabilityScore: json['sustainabilityScore'] ?? 0,
      earnedBadges: List<String>.from(json['earnedBadges'] ?? []),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // ...existing fields
      'selectedPractices': selectedPractices,
      'sustainabilityScore': sustainabilityScore,
      'earnedBadges': earnedBadges,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}
