import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

List<Product> productListPassed = [
  Product(
    id: 1,
    name: 'Product A',
    price: 19.99,
    quantity: 3,
    isWishlisted: true,
  ),
  Product(
    id: 2,
    name: 'Product B',
    price: 29.99,
    quantity: 5,
    isWishlisted: false,
  ),
  Product(
    id: 3,
    name: 'Product C',
    price: 9.99,
    quantity: 2,
    isWishlisted: true,
  ),
  // Add more products as needed
];

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier()
      : super((Cart(
            productList:
                //
                // <Product>[]
                productListPassed)));

  void addToCart(Product product) {
    final productList = state.productList;

    final productIndexInList =
        productList.indexWhere((eachProduct) => eachProduct.id == product.id);

    if (productIndexInList == -1) {
      productList.add(product);
    } else {
      productList[productIndexInList].quantity + product.quantity;
    }

    state = state.copyWith(productList: productList);
  }

  void removeThisElementFromCart(int productIndex) {
    final productList = state.productList;
    productList.removeAt(productIndex);
    state = state.copyWith(productList: productList);
  }

  void increaseQuantityAtIndex(int productIndex, {int? quantity}) {
    final productList = state.productList;
    final selectedProduct = productList.elementAt(productIndex);
    final modifiedSelectedProduct = selectedProduct.copyWith(
      quantity: quantity ?? (selectedProduct.quantity + 1),
    );
    productList[productIndex] = modifiedSelectedProduct;
    state = state.copyWith(productList: productList);
  }

  void decreaseQuantityAtIndex(int productIndex) {
    final productList = state.productList;
    final selectedProduct = productList.elementAt(productIndex);
    final modifiedSelectedProduct = selectedProduct.copyWith(
      quantity: selectedProduct.quantity > 1
          ? selectedProduct.quantity - 1
          : selectedProduct.quantity,
    );
    productList[productIndex] = modifiedSelectedProduct;
    state = state.copyWith(productList: productList);
  }

  void toggleWishlist(int productIndex, bool shouldAddToWishList) {
    final productList = state.productList;
    final selectedProduct = productList.elementAt(productIndex);
    final modifiedSelectedProduct = selectedProduct.copyWith(
      isWishlisted: shouldAddToWishList,
    );
    productList[productIndex] = modifiedSelectedProduct;
    state = state.copyWith(productList: productList);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class EachProductWidget extends ConsumerWidget {
  final Product product;
  final int index;

  const EachProductWidget(
      {super.key, required this.product, required this.index});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Product Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Quantity: ${product.quantity}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  product.isWishlisted ? 'Wishlisted' : 'Not Wishlisted',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .increaseQuantityAtIndex(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .decreaseQuantityAtIndex(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .removeThisElementFromCart(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    final isWishlisted =
                        ref.read(cartProvider).productList[index].isWishlisted;
                    ref
                        .read(cartProvider.notifier)
                        .toggleWishlist(index, !isWishlisted);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child:
              // eachProductWidget(
              //   product: Product(
              //     id: 1,
              //     name: 'Sample Product',
              //     price: 19.99,
              //     quantity: 5,
              //     isWishlisted: true,
              //   ),
              // ),
              ProductListView(),
        ),
      ),
    );
  }
}

class ProductListView extends ConsumerWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      body: Container(
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.productList.length,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 140,
                    width: 400,
                    child: EachProductWidget(
                      index: index,
                      product: cart.productList[index],
                    ),
                  );
                }),
              ),
            ),
            Container(
              height: 50,
              width: 400,
              color: Colors.black,
              child: Center(child: Text("Total:  ₦${cart.totalPrice} ")),
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool isWishlisted;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.isWishlisted = false,
  });

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, quantity: $quantity, isWishlisted: $isWishlisted}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          quantity == other.quantity &&
          isWishlisted == other.isWishlisted;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      isWishlisted.hashCode;

  Product copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
    bool? isWishlisted,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}

class Cart {
  late final List<Product> _productList;

  Cart({required productList}) {
    _productList = productList;
  }

  double get totalPrice {
    // List.fold is similar to Javascript array.reduce
    return productList.fold(0, (total, product) {
      return total + (product.price * product.quantity);
    });
  }

  List<Product> get productList => _productList;

  Cart copyWith({List<Product>? productList}) {
    return Cart(
      productList: productList ?? _productList,
    );
  }
}
