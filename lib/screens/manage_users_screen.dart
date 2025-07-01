import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  // Placeholder list (to be replaced with data from backend)
  List<Map<String, dynamic>> users = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // fetch from backend later
  }

  Future<void> _fetchUsers() async {
    // Simulate a network delay and mock data
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace this with real fetch logic (e.g., Firebase, Supabase)
    setState(() {
      users = [
        {'name': 'अमित क्रेता', 'role': 'क्रेता', 'email': 'amit@example.com'},
        {'name': 'सीता किसान', 'role': 'आपूर्तिकर्ता', 'email': 'sita@example.com'},
        {'name': 'जोन क्रेता', 'role': 'क्रेता', 'email': 'john@example.com'},
      ];
      isLoading = false;
    });
  }

  Future<void> _deleteUser(int index) async {
    // TODO: Delete user from backend here
    final deletedUser = users[index];

    setState(() {
      users.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${deletedUser['name']} हटाइयो')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('प्रयोगकर्ता व्यवस्थापन')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text("प्रयोगकर्ता फेला परेनन्।"))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          user['role'] == 'क्रेता'
                              ? Icons.shopping_cart
                              : Icons.agriculture,
                          color: Colors.green,
                        ),
                        title: Text(user['name']),
                        subtitle: Text('${user['role']} - ${user['email']}'),
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