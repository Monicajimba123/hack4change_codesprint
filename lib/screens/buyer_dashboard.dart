import 'package:flutter/material.dart';

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Dashboard'),
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
              'Welcome, Buyer!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDashboardCard(
              context,
              icon: Icons.shopping_bag,
              title: 'Browse Crops',
              subtitle: 'Find fresh produce from local farmers',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/browse');
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.shopping_cart,
              title: 'My Cart',
              subtitle: 'View crops you’ve added to your cart',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/cart');
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.history,
              title: 'Order History',
              subtitle: 'View your past orders',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/order-history');
              },
            ),

            _buildDashboardCard(
              context,
              icon: Icons.person,
              title: 'Profile',
              subtitle: 'View and edit your profile information',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/profile');
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
      elevation: 3,
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
