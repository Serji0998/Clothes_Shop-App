import 'package:first_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Function to handle logout
  void logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      'login_page', // Replace with your actual login page route
      (route) => false, // Clear the entire navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Drawer header
          DrawerHeader(
            child: Icon(
              Icons.shopify,
              size: 60,
            ),
          ),
          const SizedBox(height: 25),
          // Shop Tile
          MyListTile(
            text: "Shop",
            icon: Icons.shopping_basket_rounded,
            onTap: () => Navigator.pop(context),
          ),
          // Cart Tile
          MyListTile(
            text: "Cart",
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'cart_page');
            },
          ),
          // Profile Tile
          MyListTile(
            text: "Profile",
            icon: Icons.person,
            onTap: () {},
          ),
          // Spacer to push the "Exit" tile to the bottom
          Spacer(),
          // Exit Tile with added padding
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: MyListTile(
              text: "Exit",
              icon: Icons.logout,
              onTap: () {
                // Call the logout function when the Exit tile is tapped
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
