import 'package:flutter/material.dart';
import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({Key? key, required this.recipe}) : super(key: key);
  final SimpleRecipe recipe;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset(
                recipe.dishImage,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            recipe.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(recipe.duration, style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}
