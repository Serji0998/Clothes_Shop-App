import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:first_app/components/ProductProvider.dart';
import 'package:first_app/components/my_drawer.dart';
import 'package:first_app/components/myproductTile.dart';
import 'package:first_app/components/products.dart';
import 'package:first_app/utils/socket_client.dart';

class Homepag extends StatefulWidget {
  const Homepag({Key? key}) : super(key: key);

  @override
  _HomepagState createState() => _HomepagState();
}

class _HomepagState extends State<Homepag> {
  final SocketClient _socketClient = SocketClient.instance;

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products every 0 seconds.
  }

  Future<void> _fetchProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    // Set up a stream controller to broadcast updates
    StreamController<List<Products>> productsStreamController =
        StreamController<List<Products>>.broadcast();

    // Set the product list in the provider initially
    List<Products> initialProducts = [];

    // Emit 'getProducts' event to request initial products
    _socketClient.socket!.emit('getProducts', {});

    // Listen for 'getProductsResponse' for initial products
    _socketClient.socket!.on('getProductsResponse', (data) {
      if (data != null && data is List) {
        initialProducts = List.from(data.map((productData) {
          return Products(
            productName: productData['product_name'] ?? '',
            price: double.tryParse(productData['price'] ?? '0.0') ?? 0.0,
            description: productData['description'] ?? '',
            image: productData['image'] ?? '',
          );
        }));

        // Add the initial products to the stream
        productsStreamController.add(initialProducts);

        // Set the product list in the provider
        productProvider.setProducts(initialProducts);
      }
    });

    // Listen for 'productUpdated' and update the stream
    _socketClient.socket!.on('productUpdated', (updatedData) {
      List<Products> updatedProducts = [];
      if (updatedData != null && updatedData is List) {
        updatedProducts = List.from(updatedData.map((productData) {
          return Products(
            productName: productData['product_name'] ?? '',
            price: double.tryParse(productData['price'] ?? '0.0') ?? 0.0,
            description: productData['description'] ?? '',
            image: productData['image'] ?? '',
          );
        }));
      }

      // Add the updated products to the stream
      productsStreamController.add(updatedProducts);
    });

    // Listen for updates from the stream and update the UI
    productsStreamController.stream.listen((updatedProducts) {
      productProvider.setProducts(updatedProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Shop Page"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Please Choose your Collection:",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge, // Use your desired text style
            ),
          ),
          SizedBox(
            height: 500, // Set a fixed height for the entire ListView
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 550, // Set a fixed height for the entire ListView
      child: ListView.builder(
        itemCount: productProvider.products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          return SizedBox(
            width: 300,
            child: MyProductTile(product: product),
          );
        },
      ),
    );
  }
}
