import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  bool isNepali = true; // ✅ Language toggle

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      users = [
        {
          'name': isNepali ? 'अमित क्रेता' : 'Amit Buyer',
          'role': isNepali ? 'क्रेता' : 'Buyer',
          'email': 'amit@example.com'
        },
        {
          'name': isNepali ? 'सीता किसान' : 'Sita Farmer',
          'role': isNepali ? 'आपूर्तिकर्ता' : 'Supplier',
          'email': 'sita@example.com'
        },
        {
          'name': isNepali ? 'जोन क्रेता' : 'John Buyer',
          'role': isNepali ? 'क्रेता' : 'Buyer',
          'email': 'john@example.com'
        },
      ];
      isLoading = false;
    });
  }

  Future<void> _deleteUser(int index) async {
    final deletedUser = users[index];

    setState(() {
      users.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isNepali
              ? '${deletedUser['name']} हटाइयो'
              : '${deletedUser['name']} deleted',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? 'प्रयोगकर्ता व्यवस्थापन' : 'Manage Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? 'Switch to English' : 'नेपालीमा स्विच गर्नुहोस्',
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
                _fetchUsers();
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? Center(
                  child: Text(
                    isNepali
                        ? "प्रयोगकर्ता फेला परेनन्।"
                        : "No users found.",
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          user['role'] == (isNepali ? 'क्रेता' : 'Buyer')
                              ? Icons.shopping_cart
                              : Icons.agriculture,
                          color: Colors.green,
                        ),
                        title: Text(user['name']),
                        subtitle:
                            Text('${user['role']} - ${user['email']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(index),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
