import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('प्रशासक ड्यासबोर्ड'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'स्वागत छ, प्रशासक!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDashboardCard(
              context,
              icon: Icons.supervised_user_circle,
              title: 'प्रयोगकर्ता व्यवस्थापन',
              subtitle: 'क्रेता र आपूर्तिकर्ताहरूलाई हेर्नुहोस् र व्यवस्थापन गर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/admin/users');
                // TODO: प्रयोगकर्ता व्यवस्थापन स्क्रीनमा जानुहोस्
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.agriculture,
              title: 'बालीहरूको अवलोकन',
              subtitle: 'प्ल्याटफर्ममा सूचीबद्ध सबै बालीहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/admin/crops');
                // TODO: बालीहरूको अवलोकन स्क्रीनमा जानुहोस्
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.analytics,
              title: 'प्रतिवेदन र विश्लेषण',
              subtitle: 'प्ल्याटफर्म प्रयोग, अर्डरहरू, र तथ्याङ्कहरू',
              onTap: () {
                Navigator.pushNamed(context, '/admin/reports');
                // TODO: प्रतिवेदन स्क्रीनमा जानुहोस्
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
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}