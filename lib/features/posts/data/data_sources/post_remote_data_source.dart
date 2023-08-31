import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app/core/dio/dio_client.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;
  static PostModel? postModel;
  static List<PostModel>? posts;

  PostRemoteDataSourceImpl({required this.dioClient});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final res = await dioClient.get('posts/', '') as Response;

    if (res.statusCode == 200) {
      //http packages return String (json.encode) => to use we need json.decode
      //dio return the data in the decoded type
      final List decodedJson = res.data;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final res = await dioClient.post('posts/', '',
        body: {"title": postModel.title, "body": postModel.body}) as Response;

    if (res.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final res = await dioClient.delete('posts/$postId', '') as Response;

    if (res.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final res = await dioClient.patch('posts/$postId', '',
        body: {"title": postModel.title, "body": postModel.body}) as Response;

    if (res.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
