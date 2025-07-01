import '../models/sustainable_practice.dart';
import '../models/sustainability_badge.dart';

class SustainabilityService {
  static final SustainabilityService _instance =
      SustainabilityService._internal();
  factory SustainabilityService() => _instance;
  SustainabilityService._internal();

  static List<SustainablePractice> getAllPractices() {
    return [
      SustainablePractice(
        id: 'no_pesticide',
        name: 'No Pesticide Use',
        description: 'Completely avoid chemical pesticides',
        points: 25,
        icon: '🌿',
        category: 'Chemical-Free',
      ),
      SustainablePractice(
        id: 'organic_fertilizer',
        name: 'Organic Fertilizer Only',
        description: 'Use only organic fertilizers',
        points: 20,
        icon: '🌱',
        category: 'Chemical-Free',
      ),
      SustainablePractice(
        id: 'drip_irrigation',
        name: 'Drip Irrigation',
        description: 'Water-efficient irrigation system',
        points: 20,
        icon: '💧',
        category: 'Water Conservation',
      ),
      SustainablePractice(
        id: 'rainwater_harvesting',
        name: 'Rainwater Harvesting',
        description: 'Collect and use rainwater',
        points: 15,
        icon: '🌧️',
        category: 'Water Conservation',
      ),
      SustainablePractice(
        id: 'solar_power',
        name: 'Solar Power Usage',
        description: 'Use solar energy for farming operations',
        points: 30,
        icon: '☀️',
        category: 'Renewable Energy',
      ),
      SustainablePractice(
        id: 'crop_rotation',
        name: 'Crop Rotation',
        description: 'Practice systematic crop rotation',
        points: 15,
        icon: '🔄',
        category: 'Soil Health',
      ),
      SustainablePractice(
        id: 'composting',
        name: 'Composting',
        description: 'Create and use compost from organic waste',
        points: 10,
        icon: '🗂️',
        category: 'Waste Management',
      ),
    ];
  }

  static List<SustainabilityBadge> getAllBadges() {
    return [
      SustainabilityBadge(
        id: 'eco_starter',
        name: 'Eco Starter',
        description: 'Beginning your green journey',
        requiredPoints: 25,
        badgeIcon: '🌱',
        color: '#8BC34A',
        level: 'Bronze',
      ),
      SustainabilityBadge(
        id: 'green_guardian',
        name: 'Green Guardian',
        description: 'Committed to sustainable practices',
        requiredPoints: 50,
        badgeIcon: '🛡️',
        color: '#4CAF50',
        level: 'Silver',
      ),
      SustainabilityBadge(
        id: 'eco_champion',
        name: 'Eco Champion',
        description: 'Leading the sustainable revolution',
        requiredPoints: 100,
        badgeIcon: '🏆',
        color: '#FFD700',
        level: 'Gold',
      ),
      SustainabilityBadge(
        id: 'planet_protector',
        name: 'Planet Protector',
        description: 'Ultimate environmental steward',
        requiredPoints: 150,
        badgeIcon: '🌍',
        color: '#E91E63',
        level: 'Platinum',
      ),
    ];
  }

  int calculateScore(List<String> practiceIds) {
    final practices = getAllPractices();
    int totalScore = 0;

    for (String practiceId in practiceIds) {
      final practice = practices.firstWhere(
        (p) => p.id == practiceId,
        orElse: () => SustainablePractice(
          id: '',
          name: '',
          description: '',
          points: 0,
          icon: '',
          category: '',
        ),
      );
      totalScore += practice.points;
    }

    return totalScore;
  }

  List<SustainabilityBadge> getEarnedBadges(int score) {
    final badges = getAllBadges();
    return badges.where((badge) => score >= badge.requiredPoints).toList();
  }

  SustainabilityBadge? getHighestBadge(int score) {
    final earnedBadges = getEarnedBadges(score);
    if (earnedBadges.isEmpty) return null;

    earnedBadges.sort((a, b) => b.requiredPoints.compareTo(a.requiredPoints));
    return earnedBadges.first;
  }
}
