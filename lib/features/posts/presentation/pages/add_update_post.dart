import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_update_post_page/form_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/custom_appbar.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child:
                CustomAppBar(title: isUpdatePost ? "Edit Post" : "Add Post")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<PostsBloc, PostsState>(
              listener: (c, state) {
                if (state is AddOrDeleteOrUpdatePostSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const PostsPage()),
                      (route) => false);
                  BlocProvider.of<PostsBloc>(context)
                      .add(RefreshAllPostsEvent());
                } else if (state is AddOrDeleteOrUpdatePostUnSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingPostsState) {
                  return const LoadingWidget();
                }
                return FormWidget(
                    isUpdatePost: isUpdatePost,
                    post: isUpdatePost ? post : null);
              },
            ),
          ),
        ));
  }

}
