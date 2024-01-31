import 'package:first_app/components/products.dart';
import 'package:first_app/components/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  void removeItem(BuildContext context, Products item) {
    context.read<Shop>().removeFromCart(item);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Cart Page"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  if (index >= 0 && index < cart.length) {
                    final item = cart[index];
                    return ListTile(
                      title: Text(item.productName),
                      subtitle: Text(item.price.toStringAsFixed(2)),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => removeItem(context, item),
                      ),
                    );
                  } else {
                    // Handle the case when the index is out of bounds
                    return SizedBox.shrink(); // or another fallback widget
                  }
                },
              ),
            ),
          ],
        ));
  }
}
