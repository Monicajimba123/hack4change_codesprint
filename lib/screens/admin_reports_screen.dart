import 'package:flutter/material.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  bool isLoading = true;

  int totalUsers = 0;
  int totalCrops = 0;
  int totalOrders = 0;

  String _currentLang = 'ne'; // Default is Nepali

  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Reports & Analytics',
      'total_users': 'Total Users',
      'total_crops': 'Total Crops',
      'total_orders': 'Total Orders',
      'coming_soon': 'More analytics coming soon...',
      'loading': 'Loading...',
      'language': 'नेपाली',
    },
    'ne': {
      'title': 'रिपोर्ट र विश्लेषण',
      'total_users': 'कुल प्रयोगकर्ता',
      'total_crops': 'कुल बालीहरू',
      'total_orders': 'कुल अर्डरहरू',
      'coming_soon': 'थप विश्लेषण चाँडै आउँदैछ...',
      'loading': 'लोड हुँदैछ...',
      'language': 'English',
    },
  };

  String t(String key) => _localizedValues[_currentLang]?[key] ?? key;

  @override
  void initState() {
    super.initState();
    _fetchAnalytics();
  }

  Future<void> _fetchAnalytics() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulated backend data
    setState(() {
      totalUsers = 23;
      totalCrops = 14;
      totalOrders = 9;
      isLoading = false;
    });
  }

  Widget _buildStatCard(String title, int value, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('title')),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _currentLang = _currentLang == 'ne' ? 'en' : 'ne';
              });
            },
            child: Text(
              t('language'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(
                    t('loading'),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatCard(t('total_users'), totalUsers, Colors.blue),
                  const SizedBox(height: 16),
                  _buildStatCard(t('total_crops'), totalCrops, Colors.green),
                  const SizedBox(height: 16),
                  _buildStatCard(t('total_orders'), totalOrders, Colors.orange),
                  const SizedBox(height: 30),
                  Text(
                    t('coming_soon'),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
    );
  }
}
