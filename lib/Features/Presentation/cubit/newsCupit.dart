import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Domain/usecases/get_articles_usecase.dart';
import 'package:news/Features/Domain/usecases/get_sources_usecase.dart';
import 'package:news/Features/Presentation/cubit/newsState.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetSourcesUseCase getSourcesUseCase;
  final GetArticlesUseCase getArticlesUseCase;

  NewsCubit({required this.getSourcesUseCase, required this.getArticlesUseCase})
    : super(const NewsState());

  Future<void> fetchSources(String categoryId) async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final sources = await getSourcesUseCase(categoryId);
      final initialSourceId = sources.isNotEmpty ? sources.first.id : null;

      emit(
        state.copyWith(
          status: NewsStatus.success,
          sources: sources,
          selectedSourceId: initialSourceId,
        ),
      );

      if (initialSourceId != null) {
        fetchArticles(sourceId: initialSourceId, query: '', page: 1);
      }
    } catch (e) {
      emit(
        state.copyWith(status: NewsStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> fetchArticles({
    required String sourceId,
    required String query,
    int page = 1,
  }) async {
    if (page == 1) {
      emit(
        state.copyWith(
          status: NewsStatus.loading,
          selectedSourceId: sourceId,
          page: 1,
        ),
      );
    }

    try {
      final newArticles = await getArticlesUseCase(
        sourceId: sourceId,
        query: query,
        page: page,
      );

      final updatedArticles = page == 1
          ? newArticles
          : [...state.articles, ...newArticles];

      emit(
        state.copyWith(
          status: NewsStatus.success,
          articles: updatedArticles,
          page: page,
          hasMore: newArticles.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: NewsStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
