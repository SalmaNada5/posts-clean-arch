
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<PostsBloc>(context).add(
              DeletePostEvent(postId: postId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}