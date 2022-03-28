import 'package:flutter/material.dart';
import '../models/models.dart';
import '../components/components.dart';

class RecipeGirdView extends StatelessWidget {
  const RecipeGirdView({Key? key, required this.recipes}) : super(key: key);
  final List<SimpleRecipe> recipes;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return RecipeThumbnail(recipe: recipes[index]);
      },
      itemCount: recipes.length,
    );
  }
}
