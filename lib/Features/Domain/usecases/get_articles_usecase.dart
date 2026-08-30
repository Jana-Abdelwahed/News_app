import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Domain/repositories/newsRepository.dart';

class GetArticlesUseCase {
  final NewsRepository repository;

  GetArticlesUseCase(this.repository);

  Future<List<ArticleEntity>> call({
    required String sourceId,
    required String query,
    required int page,
  }) {
    return repository.getArticles(sourceId: sourceId, query: query, page: page);
  }
}
