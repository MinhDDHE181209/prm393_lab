import 'dart:async';

// 1. Define Product class
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

// 2. Implement ProductRepository
class ProductRepository {
  // Mock standard data list
  final List<Product> _products = [
    Product(id: 'P01', name: 'Ryzen 5 Laptop', price: 650.0),
    Product(id: 'P02', name: 'Mechanical Keyboard', price: 85.5),
  ];

  // 3. Use StreamController.broadcast() to emit new items to multiple listeners
  final StreamController<Product> _liveAddedController = StreamController<Product>.broadcast();

  // Future to simulate fetching all current products from a data source
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network latency
    return _products;
  }

  // Stream for real-time updates
  Stream<Product> liveAdded() {
    return _liveAddedController.stream;
  }

  // Method to add new product and trigger stream event
  void addProduct(Product product) {
    _products.add(product);
    _liveAddedController.sink.add(product); // Push new item into the stream
  }

  // Clean up controller when not in use
  void dispose() {
    _liveAddedController.close();
  }
}

void main() async {
  print('--- Exercise 1: Product Model & Repository ---');
  final repository = ProductRepository();

  // Listen to real-time updates BEFORE fetching or adding items
  repository.liveAdded().listen((product) {
    print('[Stream Broadcast] Real-time Alert: New product added -> ${product.name} (\$${product.price})');
  });

  // Fetch initial list using Future
  print('Fetching all products...');
  List<Product> currentProducts = await repository.getAll();
  print('Initial Product List:');
  for (var p in currentProducts) {
    print('- [${p.id}] ${p.name}: \$${p.price}');
  }

  // Simulate adding a new product dynamically after 1.5 seconds
  await Future.delayed(Duration(milliseconds: 1500));
  repository.addProduct(Product(id: 'P03', name: 'Wireless Gaming Mouse', price: 45.0));

  // Wait a moment for stream log to finish before ending program execution
  await Future.delayed(Duration(seconds: 1));
  repository.dispose();
}