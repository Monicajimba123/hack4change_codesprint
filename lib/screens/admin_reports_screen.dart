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

  @override
  void initState() {
    super.initState();
    _fetchAnalytics();
  }

  Future<void> _fetchAnalytics() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace these with actual backend stats
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
            Text(title,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
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
      appBar: AppBar(title: const Text("रिपोर्ट र विश्लेषण")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatCard("कुल प्रयोगकर्ता", totalUsers, Colors.blue),
                  const SizedBox(height: 16),
                  _buildStatCard("कुल बालीहरू", totalCrops, Colors.green),
                  const SizedBox(height: 16),
                  _buildStatCard("कुल अर्डरहरू", totalOrders, Colors.orange),
                  const SizedBox(height: 30),
                  const Text(
                    "थप विश्लेषण चाँडै आउँदैछ...",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
    );
  }
}