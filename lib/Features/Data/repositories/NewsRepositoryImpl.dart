import 'package:news/Features/Data/datasources/news_local_data_source.dart';
import 'package:news/Features/Data/datasources/news_remote_data_source.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Domain/entities/source_entity.dart';
import 'package:news/Features/Domain/repositories/newsRepository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<SourceEntity>> getSources(String categoryId) async {
    return await remoteDataSource.getSources(categoryId);
  }

  @override
  Future<List<ArticleEntity>> getArticles({
    required String sourceId,
    required String query,
    required int page,
  }) async {
    return await remoteDataSource.getArticles(sourceId, query, page);
  }
}
