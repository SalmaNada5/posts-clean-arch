import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';
import 'package:posts_app/features/posts/presentation/widgets/post_details_page/post_detail_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/custom_appbar.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(title: 'Post Details')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
