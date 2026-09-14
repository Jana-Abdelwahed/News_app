import 'package:news/Features/Domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({super.id, super.name, super.description, super.url});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'url': url};
  }

  factory SourceModel.fromEntity(SourceEntity entity) {
    return SourceModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      url: entity.url,
    );
  }

  SourceEntity toEntity() {
    return SourceEntity(id: id, name: name, description: description, url: url);
  }
}
