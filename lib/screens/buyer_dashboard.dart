import 'package:flutter/material.dart';

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('क्रेता ड्यासबोर्ड'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');  // Navigate to login page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'स्वागत छ, क्रेता!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDashboardCard(
              context,
              icon: Icons.shopping_bag,
              title: 'बालीहरू हेर्नुहोस्',
              subtitle: 'स्थानीय किसानबाट ताजा उत्पादन फेला पार्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/browse');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.shopping_cart,
              title: 'मेरो कार्ट',
              subtitle: 'तपाईंले कार्टमा थप्नुभएका बालीहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/cart');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.history,
              title: 'अर्डर इतिहास',
              subtitle: 'तपाईंका विगतका अर्डरहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/order-history');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.person,
              title: 'प्रोफाइल',
              subtitle: 'आफ्नो प्रोफाइल जानकारी हेर्नुहोस् र सम्पादन गर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/profile');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.map,
              title: 'नक्सा खोल्नुहोस्',
              subtitle: 'नजिकका किसानहरू र बालीहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.agriculture,
              title: 'बाली सिफारिसहरू',
              subtitle: 'क्षेत्र अनुसार सुझावहरू प्राप्त गर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/recommendations');
              },
            ),
          ],
        ),
      ),
    );
  }
}
