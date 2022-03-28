import 'grocery_item_screen.dart';
import 'package:chap5_practice/models/models.dart';
import 'package:chap5_practice/screens/empty_grocery_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<GroceryManager>(context, listen: false).createNewItem();
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (context, groceryManager, child) {
        if (groceryManager.groceryItems.isNotEmpty) {
          //TODO 25: ADD GroceryListScreen
          return GroceryListScreen(manager: groceryManager);
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
