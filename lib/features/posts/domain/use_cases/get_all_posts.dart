import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/domain_repository/post_repo.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase({required this.repository});
  Future<Either<Failure, List<Post>>> call() {
    return repository.getAllPosts();
  }
}
