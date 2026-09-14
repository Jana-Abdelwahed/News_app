import 'dart:io';

import 'package:http/http.dart' as http;
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
    try {
      final remoteSources = await remoteDataSource.getSources(categoryId);

      if (remoteSources.isNotEmpty) {
        await localDataSource.cacheSources(categoryId, remoteSources);
      }

      return remoteSources.map((model) => model.toEntity()).toList();
    } on SocketException catch (_) {
      return _getCachedSources(categoryId);
    } on http.ClientException catch (_) {
      return _getCachedSources(categoryId);
    } catch (_) {
      return _getCachedSources(categoryId);
    }
  }

  @override
  Future<List<ArticleEntity>> getArticles({
    required String sourceId,
    required String query,
    required int page,
  }) async {
    final cacheKey = 'articles_${sourceId}_$query';

    try {
      final remoteArticles = await remoteDataSource.getArticles(
        sourceId,
        query,
        page,
      );

      if (remoteArticles.isNotEmpty) {
        await localDataSource.cacheArticles(cacheKey, remoteArticles);
      }

      return remoteArticles.map((model) => model.toEntity()).toList();
    } on SocketException catch (_) {
      return _getCachedArticles(cacheKey);
    } on http.ClientException catch (_) {
      return _getCachedArticles(cacheKey);
    } catch (_) {
      return _getCachedArticles(cacheKey);
    }
  }

  List<SourceEntity> _getCachedSources(String categoryId) {
    final localSources = localDataSource.getCachedSources(categoryId);

    if (localSources != null && localSources.isNotEmpty) {
      return localSources.map((model) => model.toEntity()).toList();
    }

    throw Exception("You are offline and no cached sources were found.");
  }

  List<ArticleEntity> _getCachedArticles(String cacheKey) {
    final localArticles = localDataSource.getCachedArticles(cacheKey);

    if (localArticles != null && localArticles.isNotEmpty) {
      return localArticles.map((model) => model.toEntity()).toList();
    }

    throw Exception("You are offline and no cached articles were found.");
  }
}
