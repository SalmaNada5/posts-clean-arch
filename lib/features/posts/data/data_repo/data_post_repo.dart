import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/internet/internet_info.dart';
import 'package:posts_app/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/domain_repository/post_repo.dart';
import 'package:posts_app/features/posts/domain/entitis/post_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final InternetInfo internetInfo;
  PostRepositoryImpl(
      {required this.internetInfo,required this.postRemoteDataSource, required this.postLocalDataSource});

@override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await internetInfo.isConnected) {
      try {
        List<PostModel> posts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(posts);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    if (await internetInfo.isConnected) {
      try {
        PostModel postModel = PostModel(title: post.title, body: post.body);
        await postRemoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await internetInfo.isConnected) {
      try {
        await postRemoteDataSource.deletePost(postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    if (await internetInfo.isConnected) {
      try {
        PostModel postModel = PostModel(title: post.title, body: post.body);
        await postRemoteDataSource.updatePost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
