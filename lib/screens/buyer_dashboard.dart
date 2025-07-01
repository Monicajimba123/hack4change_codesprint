import 'package:flutter/material.dart';

class BuyerDashboard extends StatefulWidget {
  const BuyerDashboard({super.key});

  @override
  State<BuyerDashboard> createState() => _BuyerDashboardState();
}

class _BuyerDashboardState extends State<BuyerDashboard> {
  bool isNepali = true; // 🔥 Language toggle flag

  // 🔥 Get text based on selected language
  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  // 🔥 Build a reusable card
  Widget _buildDashboardCard({
    required IconData icon,
    required String enTitle,
    required String neTitle,
    required String enSubtitle,
    required String neSubtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green),
        title: Text(
          getText(en: enTitle, ne: neTitle),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(getText(en: enSubtitle, ne: neSubtitle)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  // 🔥 Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getText(en: 'Buyer Dashboard', ne: 'क्रेता ड्यासबोर्ड'),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                isNepali = !isNepali; // 🔥 Toggle language
              });
            },
            tooltip: getText(en: 'Language', ne: 'भाषा'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              getText(en: 'Welcome, Buyer!', ne: 'स्वागत छ, क्रेता!'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDashboardCard(
              icon: Icons.shopping_bag,
              enTitle: 'Browse Crops',
              neTitle: 'बालीहरू हेर्नुहोस्',
              enSubtitle: 'Find fresh produce from local farmers',
              neSubtitle: 'स्थानीय किसानबाट ताजा उत्पादन फेला पार्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/browse');
              },
            ),
            _buildDashboardCard(
              icon: Icons.shopping_cart,
              enTitle: 'My Cart',
              neTitle: 'मेरो कार्ट',
              enSubtitle: 'View crops added to your cart',
              neSubtitle: 'तपाईंले कार्टमा थप्नुभएका बालीहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/cart');
              },
            ),
            _buildDashboardCard(
              icon: Icons.history,
              enTitle: 'Order History',
              neTitle: 'अर्डर इतिहास',
              enSubtitle: 'Check your previous orders',
              neSubtitle: 'तपाईंका विगतका अर्डरहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/order-history');
              },
            ),
            _buildDashboardCard(
              icon: Icons.person,
              enTitle: 'Profile',
              neTitle: 'प्रोफाइल',
              enSubtitle: 'View and edit your profile info',
              neSubtitle: 'आफ्नो प्रोफाइल जानकारी हेर्नुहोस् र सम्पादन गर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/profile');
              },
            ),
            _buildDashboardCard(
              icon: Icons.map,
              enTitle: 'Open Map',
              neTitle: 'नक्सा खोल्नुहोस्',
              enSubtitle: 'Find nearby farmers and crops',
              neSubtitle: 'नजिकका किसानहरू र बालीहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
            ),
            _buildDashboardCard(
              icon: Icons.agriculture,
              enTitle: 'Crop Recommendations',
              neTitle: 'बाली सिफारिसहरू',
              enSubtitle: 'Get suggestions based on region',
              neSubtitle: 'क्षेत्र अनुसार सुझावहरू प्राप्त गर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/recommendations');
              },
            ),
            _buildDashboardCard(
              icon: Icons.local_shipping,
              enTitle: 'Transportation Service',
              neTitle: 'ढुवानी सेवा',
              enSubtitle: 'Check available transport services',
              neSubtitle: 'उपलब्ध यातायात सेवाहरू हेर्नुहोस्',
              onTap: () {
                Navigator.pushNamed(context, '/transport');
              },
            ),
            _buildDashboardCard(
              icon: Icons.chat,
              enTitle: 'Chatbot Help',
              neTitle: 'च्याटबोट सहायता',
              enSubtitle: 'Need help? Chat with us',
              neSubtitle: 'कुनै प्रश्न? हामी सहायता गर्छौं',
              onTap: () {
                Navigator.pushNamed(context, '/buyer/chatbot');
              },
            ),
          ],
        ),
      ),
    );
  }
}
