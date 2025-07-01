class OrderStore {
  static final List<Map<String, dynamic>> _orders = [];

  static void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
  }

  static List<Map<String, dynamic>> getOrders() {
    return _orders;
  }

  static void removeOrderAt(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders.removeAt(index);
    }
  }
}
