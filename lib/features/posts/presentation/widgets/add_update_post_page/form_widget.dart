
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_update_post_page/form_submitted_button.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_update_post_page/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<PostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<PostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}