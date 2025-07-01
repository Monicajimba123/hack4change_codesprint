import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _currentLang = 'ne'; // Default Nepali

  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'dashboard': 'Admin Dashboard',
      'welcome': 'Welcome, Admin!',
      'user_management': 'User Management',
      'user_management_sub':
          'View and manage buyers and suppliers',
      'crop_overview': 'Crop Overview',
      'crop_overview_sub':
          'View all crops listed on the platform',
      'reports_analytics': 'Reports & Analytics',
      'reports_analytics_sub':
          'Platform usage, orders, and statistics',
      'logout': 'Logout',
    },
    'ne': {
      'dashboard': 'प्रशासक ड्यासबोर्ड',
      'welcome': 'स्वागत छ, प्रशासक!',
      'user_management': 'प्रयोगकर्ता व्यवस्थापन',
      'user_management_sub': 'क्रेता र आपूर्तिकर्ताहरूलाई हेर्नुहोस् र व्यवस्थापन गर्नुहोस्',
      'crop_overview': 'बालीहरूको अवलोकन',
      'crop_overview_sub': 'प्ल्याटफर्ममा सूचीबद्ध सबै बालीहरू हेर्नुहोस्',
      'reports_analytics': 'प्रतिवेदन र विश्लेषण',
      'reports_analytics_sub': 'प्ल्याटफर्म प्रयोग, अर्डरहरू, र तथ्याङ्कहरू',
      'logout': 'लगआउट',
    },
  };

  String t(String key) => _localizedValues[_currentLang]?[key] ?? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('dashboard')),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _currentLang = _currentLang == 'ne' ? 'en' : 'ne';
              });
            },
            child: Text(
              _currentLang == 'ne' ? 'English' : 'नेपाली',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            tooltip: t('logout'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              t('welcome'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDashboardCard(
              context,
              icon: Icons.supervised_user_circle,
              title: t('user_management'),
              subtitle: t('user_management_sub'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/users');
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.agriculture,
              title: t('crop_overview'),
              subtitle: t('crop_overview_sub'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/crops');
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.analytics,
              title: t('reports_analytics'),
              subtitle: t('reports_analytics_sub'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/reports');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.green.shade700),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
