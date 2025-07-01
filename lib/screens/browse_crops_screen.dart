import 'package:flutter/material.dart';
import 'farmer_detail_screen.dart';

class BrowseCropsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> crops;
  final Function(Map<String, dynamic>) onAddToCart;

  const BrowseCropsScreen({
    super.key,
    required this.crops,
    required this.onAddToCart,
  });

  @override
  State<BrowseCropsScreen> createState() => _BrowseCropsScreenState();
}

class _BrowseCropsScreenState extends State<BrowseCropsScreen> {
  late List<Map<String, dynamic>> _filteredCrops;
  final TextEditingController _searchController = TextEditingController();

  String _currentLang = 'ne'; // Default to Nepali

  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Browse Crops',
      'search_hint': 'Search crops...',
      'no_results': 'No crops found.',
      'added_to_cart': 'added to cart',
      'language': 'नेपाली',
    },
    'ne': {
      'title': 'बालीहरू हेर्नुहोस्',
      'search_hint': 'बाली खोज्नुहोस्...',
      'no_results': 'कुनै बाली फेला परेन।',
      'added_to_cart': 'कार्टमा थपियो',
      'language': 'English',
    },
  };

  String t(String key) => _localizedValues[_currentLang]?[key] ?? key;

  @override
  void initState() {
    super.initState();
    _filteredCrops = widget.crops;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCrops = widget.crops
          .where((crop) => crop['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToFarmerDetail(Map<String, dynamic> crop) async {
    final selectedCrop = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerDetailScreen(crop: crop),
      ),
    );

    if (selectedCrop != null) {
      widget.onAddToCart(selectedCrop);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${selectedCrop['name']} ${t('added_to_cart')}'),
        ),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: t('search_hint'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredCrops.isEmpty
                  ? Center(child: Text(t('no_results')))
                  : ListView.builder(
                      itemCount: _filteredCrops.length,
                      itemBuilder: (context, index) {
                        final crop = _filteredCrops[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.local_florist,
                                color: Colors.green),
                            title: Text(crop['name']),
                            subtitle:
                                Text("रु. ${crop['price']}/के.जि."), // Price format
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () => _navigateToFarmerDetail(crop),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
