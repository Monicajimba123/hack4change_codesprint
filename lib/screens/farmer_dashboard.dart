import 'package:flutter/material.dart';
import '../../widgets/common/sustainability_badge_display.dart';
import '../../services/sustainability_service.dart';
import 'dart:math';
import 'smart_crop_recommendation.dart';
import 'crop_calendar_screen.dart';
import 'chat_screen.dart';
import 'simple_map_screen.dart';
import 'transportation_service_screen.dart'; // ✅ Transport screen import

class FarmerDashboard extends StatelessWidget {
  final String farmerName;
  final VoidCallback onAddCropTap;
  final VoidCallback onMyCropsTap;

  FarmerDashboard({
    super.key,
    required this.farmerName,
    required this.onAddCropTap,
    required this.onMyCropsTap,
  });

  final List<String> _quotes = const [
    "रुख रोप्न सबैभन्दा राम्रो समय २० वर्ष अगाडि थियो। दोस्रो राम्रो समय अहिले हो।",
    "दिगोपन कुनै लक्ष्य होइन, सोच्ने तरिका हो।",
    "स्वस्थ माटो, स्वस्थ जीवन।",
    "माया गरेर उमार, गर्वले बटार।",
  ];

  @override
  Widget build(BuildContext context) {
    final int sustainabilityScore = 65;
    final today = DateTime.now();
    final String dateStr = "${today.day}/${today.month}/${today.year}";
    final String quote = _quotes[Random().nextInt(_quotes.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('कृषक ड्यासबोर्ड'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "रिफ्रेस गर्नुहोस्",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ड्यासबोर्ड रिफ्रेस भयो!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "लगआउट",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            tooltip: "च्याट खोल्नुहोस्",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    buyerName: 'खरिदकर्ता',
                    sellerName: farmerName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "शुभदिन, $farmerName!",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "आज: $dateStr",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            _buildSustainabilityOverview(context, sustainabilityScore),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAnimatedDashboardCard(
                    icon: Icons.add_circle,
                    label: 'नयाँ बाली थप्नुहोस्',
                    color: Colors.green,
                    onTap: onAddCropTap,
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.list_alt,
                    label: 'मेरो बालीहरू',
                    color: Colors.orange,
                    onTap: onMyCropsTap,
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.shopping_bag,
                    label: 'अर्डरहरू',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, '/farmer/orders');
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.person,
                    label: 'प्रोफाइल',
                    color: Colors.purple,
                    onTap: () {
                      Navigator.pushNamed(context, '/farmer/profile');
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.map,
                    label: 'नक्सा खोल्नुहोस्',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleMapScreen(),
                        ),
                      );
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.agriculture,
                    label: 'स्मार्ट बाली सिफारिस',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SmartCropRecommendationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.calendar_today,
                    label: 'बाली तालिका',
                    color: Colors.brown,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CropCalendarScreen(),
                        ),
                      );
                    },
                  ),
                  // ✅ Added Transportation Card
                  _buildAnimatedDashboardCard(
                    icon: Icons.local_shipping,
                    label: 'ढुवानी सेवा',
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TransportationServiceScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "\"$quote\"",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.teal.shade700,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSustainabilityOverview(BuildContext context, int score) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'तपाईंको दिगोपन स्थिति',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SustainabilityBadgeDisplay(
              sustainabilityScore: score,
              showScore: true,
              compact: false,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sustainability-settings');
              },
              child: const Text('दिगो अभ्यासहरू अपडेट गर्नुहोस्'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedDashboardCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: _buildDashboardCard(
        icon: icon,
        label: label,
        color: color,
        onTap: onTap,
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
