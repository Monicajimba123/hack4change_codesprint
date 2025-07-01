import 'package:flutter/material.dart';
import '../../models/sustainability_badge.dart';
import '../../services/sustainability_service.dart';

class SustainabilityBadgeDisplay extends StatelessWidget {
  final int sustainabilityScore;
  final bool showScore;
  final bool compact;

  const SustainabilityBadgeDisplay({
    super.key,
    required this.sustainabilityScore,
    this.showScore = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final highestBadge = SustainabilityService().getHighestBadge(
      sustainabilityScore,
    );
    if (highestBadge == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(highestBadge.badgeIcon, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                highestBadge.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (showScore) Text('$sustainabilityScore pts'),
            ],
          ),
        ],
      ),
    );
  }
}
