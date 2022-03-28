import 'package:flutter/material.dart';
import '../components/components.dart';
import 'grocery_item_screen.dart';
import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);
  final GroceryManager manager;
  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final item = groceryItems[index];
            // TODO 28: Wrap in a Dismissable
            // TODO 27: Wrap in an InkWell
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              onDismissed: (direction) {
                manager.deleteItem(index);
                final snackBar = SnackBar(
                  content: Row(children: [
                    Text('Delete ${item.name} sucessfully!'),
                    const SizedBox(width: 5.0),
                    const Icon(Icons.thumb_up, color: Colors.black),
                  ]),
                  duration: const Duration(milliseconds: 500),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: InkWell(
                onTap: () {
                  manager.groceryItemTapped(index);
                },
                child: GroceryTitle(
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  },
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
          itemCount: groceryItems.length),
    );
  }
}
