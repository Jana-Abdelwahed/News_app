import 'package:news/api/api_manager.dart';
import 'package:news/models/news_response.dart';
import 'package:news/models/source_response.dart';
import 'package:news/utils/local_storage_manager.dart';

class NewsRepository {
  static Future<List<Source>> fetchSources(String categoryId) async {
    List<Source> sourcesList = [];

    final cachedData = LocalStorageManager.getCachedArticles(
      'sources_$categoryId',
    );
    if (cachedData != null) {
      sourcesList = cachedData
          .map((jsonItem) => Source.fromJson(jsonItem))
          .toList();
    }

    try {
      var response = await ApiManager.getSources(categoryId);
      if (response.sources != null && response.sources!.isNotEmpty) {
        final rawJson = response.sources!.map((s) => s.toJson()).toList();
        await LocalStorageManager.cacheArticles('sources_$categoryId', rawJson);

        sourcesList = response.sources!;
      }
    } catch (error) {
      print(
        "Offline Mode: Serving cached sources for $categoryId. Error: $error",
      );
    }

    return sourcesList;
  }

  static Future<List<Article>> fetchArticles(
    String sourceId,
    String query,
    int page,
  ) async {
    List<Article> articlesList = [];

    final cacheKey = 'articles_${sourceId}_q_${query}_p_$page';

    final cachedData = LocalStorageManager.getCachedArticles(cacheKey);
    if (cachedData != null) {
      articlesList = cachedData
          .map((jsonItem) => Article.fromJson(jsonItem))
          .toList();
    }

    try {
      var response = await ApiManager.getNews(sourceId, query, 'page');
      if (response.articles != null && response.articles!.isNotEmpty) {
        await LocalStorageManager.cacheArticles(
          cacheKey,
          response.rawArticlesJsonList,
        );

        articlesList = response.articles!;
      }
    } catch (error) {
      print(
        "Offline Mode: Serving cached articles for source $sourceId. Error: $error",
      );
    }

    return articlesList;
  }
}
