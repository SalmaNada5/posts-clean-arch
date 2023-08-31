import 'package:flutter/material.dart';
import 'package:posts_app/constants/consts.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';
import 'package:posts_app/features/posts/presentation/pages/post_details_page.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.posts});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () {
            Constants.navigateTo(PostDetailPage(post: posts[index]));
          },
          leading: Text('${posts[index].id}'),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        );
      },
      separatorBuilder: (_, index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemCount: posts.length,
    );
  }
}
