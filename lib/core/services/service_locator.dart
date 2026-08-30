import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news/Features/Data/datasources/news_local_data_source.dart';
import 'package:news/Features/Data/datasources/news_remote_data_source.dart';
import 'package:news/Features/Data/repositories/NewsRepositoryImpl.dart';
import 'package:news/Features/Domain/repositories/newsRepository.dart';
import 'package:news/Features/Domain/usecases/get_articles_usecase.dart';
import 'package:news/Features/Domain/usecases/get_sources_usecase.dart';
import 'package:news/Features/Presentation/cubit/newsCupit.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetSourcesUseCase(sl()));
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));

  sl.registerFactory(
    () => NewsCubit(getSourcesUseCase: sl(), getArticlesUseCase: sl()),
  );
}
