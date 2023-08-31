import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/domain_repository/post_repo.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}