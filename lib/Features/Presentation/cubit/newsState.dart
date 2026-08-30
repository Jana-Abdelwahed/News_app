import 'package:equatable/equatable.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Domain/entities/source_entity.dart';

enum NewsStatus { initial, loading, success, failure }

class NewsState extends Equatable {
  final NewsStatus status;
  final List<SourceEntity> sources;
  final List<ArticleEntity> articles;
  final String? selectedSourceId;
  final String? errorMessage;
  final int page;
  final bool hasMore;

  const NewsState({
    this.status = NewsStatus.initial,
    this.sources = const [],
    this.articles = const [],
    this.selectedSourceId,
    this.errorMessage,
    this.page = 1,
    this.hasMore = true,
  });

  NewsState copyWith({
    NewsStatus? status,
    List<SourceEntity>? sources,
    List<ArticleEntity>? articles,
    String? selectedSourceId,
    String? errorMessage,
    int? page,
    bool? hasMore,
  }) {
    return NewsState(
      status: status ?? this.status,
      sources: sources ?? this.sources,
      articles: articles ?? this.articles,
      selectedSourceId: selectedSourceId ?? this.selectedSourceId,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sources,
    articles,
    selectedSourceId,
    errorMessage,
    page,
    hasMore,
  ];
}
