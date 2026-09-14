import 'package:news/Features/Data/models/articleModel.dart';
import 'package:news/Features/Data/models/sourceModel.dart';
import 'package:news/core/utils/local_storage_manager.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheSources(String categoryId, List<SourceModel> sources);
  List<SourceModel>? getCachedSources(String categoryId);

  Future<void> cacheArticles(String cacheKey, List<ArticleModel> articles);
  List<ArticleModel>? getCachedArticles(String cacheKey);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<void> cacheSources(
    String categoryId,
    List<SourceModel> sources,
  ) async {
    final rawJson = sources.map((s) => s.toJson()).toList();
    await LocalStorageManager.cacheArticles('sources_$categoryId', rawJson);
  }

  @override
  List<SourceModel>? getCachedSources(String categoryId) {
    final cached = LocalStorageManager.getCachedArticles('sources_$categoryId');
    if (cached == null) return null;

    return cached.map((item) {
      final jsonMap = Map<String, dynamic>.from(item as Map);
      return SourceModel.fromJson(jsonMap);
    }).toList();
  }

  @override
  Future<void> cacheArticles(
    String cacheKey,
    List<ArticleModel> articles,
  ) async {
    final rawJson = articles.map((a) => a.toJson()).toList();
    await LocalStorageManager.cacheArticles(cacheKey, rawJson);
  }

  @override
  List<ArticleModel>? getCachedArticles(String cacheKey) {
    final cached = LocalStorageManager.getCachedArticles(cacheKey);
    if (cached == null) return null;

    return cached.map((item) {
      final jsonMap = Map<String, dynamic>.from(item as Map);
      return ArticleModel.fromJson(jsonMap);
    }).toList();
  }
}
