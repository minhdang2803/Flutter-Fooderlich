import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';

class FriendPostTitleView extends StatelessWidget {
  const FriendPostTitleView({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Socical Chefs 🧑‍🍳',
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 16),
          ListView.separated(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FriendPostTitle(
                  post: posts[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemCount: posts.length),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
