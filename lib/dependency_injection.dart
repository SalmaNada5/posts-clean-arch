import 'package:get_it/get_it.dart';
import 'package:posts_app/core/dio/dio_client.dart';
import 'package:posts_app/core/internet/internet_info.dart';
import 'package:posts_app/features/posts/data/data_repo/data_post_repo.dart';
import 'package:posts_app/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/domain/domain_repository/post_repo.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs

  sl.registerFactory<PostsBloc>(
    () => PostsBloc(
        getAllPosts: sl(), addPost: sl(), deletePost: sl(), updatePost: sl()),
  );
  //repositories
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
        internetInfo: sl(),
        postRemoteDataSource: sl(),
        postLocalDataSource: sl()),
  );

  //useCases
  sl.registerLazySingleton(
    () => GetAllPostsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => AddPostUsecase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => UpdatePostUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => DeletePostUseCase(repository: sl()),
  );

  //datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(sharedPreferences: sl()),
  );

//external

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );


  sl.registerLazySingleton(
    () => DioClient(),
  );

  sl.registerLazySingleton<InternetInfo>(
    () => InternetInfoImpl(),
  );
}
