import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
              'Welcome, Admin!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDashboardCard(
              context,
              icon: Icons.supervised_user_circle,
              title: 'Manage Users',
              subtitle: 'View and manage buyers and suppliers',
              onTap: () {
                Navigator.pushNamed(context, '/admin/users');
                // TODO: Navigate to Manage Users screen
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.agriculture,
              title: 'Crops Overview',
              subtitle: 'See all crops listed on the platform',
              onTap: () {
                Navigator.pushNamed(context, '/admin/crops');
                // TODO: Navigate to Crops Overview screen
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.analytics,
              title: 'Reports & Analytics',
              subtitle: 'Platform usage, orders, and statistics',
              onTap: () {
                Navigator.pushNamed(context, '/admin/reports');
                // TODO: Navigate to Reports screen
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
