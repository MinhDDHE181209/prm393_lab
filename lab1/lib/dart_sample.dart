import 'dart:async';

class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$$price)';
  }
}

class ProductRepository {
  final List<Product> _products = [];

  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

void main() async {
  ProductRepository repo = ProductRepository();

  repo.liveAdded().listen((product) {
    print('New product: $product');
  });

  repo.addProduct(Product(1, 'Laptop', 1500));
  repo.addProduct(Product(2, 'Mouse', 25.5));
  repo.addProduct(Product(3, 'Keyboard', 75));

  print('\nAll products:\n');

  List<Product> products = await repo.getAll();

  for (var product in products) {
    print(product);
  }

  repo.dispose();
}