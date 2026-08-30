import 'package:news/Features/Domain/entities/source_entity.dart';
import 'package:news/Features/Domain/repositories/newsRepository.dart';
import 'package:news/core/usecase/usecase.dart';

class GetSourcesUseCase implements UseCase<List<SourceEntity>, String> {
  final NewsRepository repository;

  GetSourcesUseCase(this.repository);

  @override
  Future<List<SourceEntity>> call(String categoryId) {
    return repository.getSources(categoryId);
  }
}
