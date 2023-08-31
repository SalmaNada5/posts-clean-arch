import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:posts_app/constants/consts.dart';
import 'package:posts_app/core/errors/failures.dart';
// import 'package:posts_app/core/errors/logger.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  final AddPostUsecase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  PostsBloc(
      {required this.getAllPosts,
      required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold(
            (failure) => emit(
                FailureLoadingPostsState(message: _failureToMessage(failure))),
            (posts) {
         
          emit(LoadedPostsState(posts: posts));
        });
      } else if (event is AddPostEvent) {
        final failureOrUnit = await addPost(event.post);
        failureOrUnit.fold(
            (failure) => emit(AddOrDeleteOrUpdatePostUnSuccessfully(
                message: _failureToMessage(failure))), (_) {
          emit(const AddOrDeleteOrUpdatePostSuccessfully(
              message: 'Post Added Successfully!'));
        });
      } else if (event is UpdatePostEvent) {
        final failureOrUnit = await updatePost(event.post);
       
        failureOrUnit.fold(
            (failure) => emit(AddOrDeleteOrUpdatePostUnSuccessfully(
                message: _failureToMessage(failure))), (_) {
          
          emit(const AddOrDeleteOrUpdatePostSuccessfully(
              message: 'Post Updated Successfully!'));
        });
      } else if (event is DeletePostEvent) {
        final failureOrUnit = await deletePost(event.postId);
        failureOrUnit.fold(
            (failure) => emit(AddOrDeleteOrUpdatePostUnSuccessfully(
                message: _failureToMessage(failure))), (_) {
          emit(const AddOrDeleteOrUpdatePostSuccessfully(
              message: 'Post deleted Successfully!'));
        });
      }
    });
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case EmptyCacheFailure:
        return 'No data';
      case OfflineFailure:
        return 'Your\'re offline';
      default:
        return 'unhandeled exception';
    }
  }
}
