import 'package:flutter/material.dart';
import '../../widgets/common/sustainability_badge_display.dart';
import 'dart:math';
import 'smart_crop_recommendation.dart';
import 'crop_calendar_screen.dart';
import 'chat_screen.dart';
import 'simple_map_screen.dart';
import 'transportation_service_screen.dart';

class FarmerDashboard extends StatefulWidget {
  final String farmerName;
  final VoidCallback onAddCropTap;
  final VoidCallback onMyCropsTap;

  const FarmerDashboard({
    super.key,
    required this.farmerName,
    required this.onAddCropTap,
    required this.onMyCropsTap,
  });

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  bool isNepali = true;

  final List<Map<String, String>> _quotes = [
    {
      'en': "The best time to plant a tree was 20 years ago. The second best time is now.",
      'ne': "रुख रोप्न सबैभन्दा राम्रो समय २० वर्ष अगाडि थियो। दोस्रो राम्रो समय अहिले हो।"
    },
    {
      'en': "Sustainability is not a goal, it’s a mindset.",
      'ne': "दिगोपन कुनै लक्ष्य होइन, सोच्ने तरिका हो।"
    },
    {
      'en': "Healthy soil, healthy life.",
      'ne': "स्वस्थ माटो, स्वस्थ जीवन।"
    },
    {
      'en': "Grow with love, harvest with pride.",
      'ne': "माया गरेर उमार, गर्वले बटार।"
    },
  ];

  String tr(String en, String ne) => isNepali ? ne : en;

  @override
  Widget build(BuildContext context) {
    final int sustainabilityScore = 65;
    final today = DateTime.now();
    final String dateStr = "${today.day}/${today.month}/${today.year}";
    final Map<String, String> quote = _quotes[Random().nextInt(_quotes.length)];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Farmer Dashboard', 'कृषक ड्यासबोर्ड')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: tr('Switch Language', 'भाषा परिवर्तन गर्नुहोस्'),
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: tr("Refresh", "रिफ्रेस गर्नुहोस्"),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tr('Dashboard refreshed!', 'ड्यासबोर्ड रिफ्रेस भयो!'))),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: tr("Logout", "लगआउट"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            tooltip: tr("Open Chat", "च्याट खोल्नुहोस्"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    buyerName: tr('Buyer', 'खरिदकर्ता'),
                    sellerName: widget.farmerName,
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
              "${tr('Good day', 'शुभदिन')}, ${widget.farmerName}!",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "${tr('Today', 'आज')}: $dateStr",
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
                    label: tr('Add New Crop', 'नयाँ बाली थप्नुहोस्'),
                    color: Colors.green,
                    onTap: widget.onAddCropTap,
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.list_alt,
                    label: tr('My Crops', 'मेरो बालीहरू'),
                    color: Colors.orange,
                    onTap: widget.onMyCropsTap,
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.shopping_bag,
                    label: tr('Orders', 'अर्डरहरू'),
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, '/farmer/orders');
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.person,
                    label: tr('Profile', 'प्रोफाइल'),
                    color: Colors.purple,
                    onTap: () {
                      Navigator.pushNamed(context, '/farmer/profile');
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.map,
                    label: tr('Open Map', 'नक्सा खोल्नुहोस्'),
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
                    label: tr('Smart Crop Recommendation', 'स्मार्ट बाली सिफारिस'),
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SmartCropRecommendationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildAnimatedDashboardCard(
                    icon: Icons.calendar_today,
                    label: tr('Crop Calendar', 'बाली तालिका'),
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
                  _buildAnimatedDashboardCard(
                    icon: Icons.local_shipping,
                    label: tr('Transportation Service', 'ढुवानी सेवा'),
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransportationServiceScreen(),
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
                "\"${quote[isNepali ? 'ne' : 'en']}\"",
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
            Text(
              tr('Your Sustainability Status', 'तपाईंको दिगोपन स्थिति'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              child: Text(tr('Update Sustainable Practices', 'दिगो अभ्यासहरू अपडेट गर्नुहोस्')),
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
