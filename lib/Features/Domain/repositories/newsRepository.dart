import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Domain/entities/source_entity.dart';

abstract class NewsRepository {
  Future<List<SourceEntity>> getSources(String categoryId);
  Future<List<ArticleEntity>> getArticles({
    required String sourceId,
    required String query,
    required int page,
  });
}
