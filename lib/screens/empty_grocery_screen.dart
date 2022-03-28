import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),
            const SizedBox(height: 16),
            const Text('No Groceries', style: TextStyle(fontSize: 21.0)),
            const SizedBox(height: 16),
            const Text('Shopping for ingredients? Write them down!',
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .goToRecipes();
              },
              textColor: Colors.white,
              color: Colors.green,
              child: const Text('Browse Recipes'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            )
          ],
        ),
      ),
    );
  }
}
