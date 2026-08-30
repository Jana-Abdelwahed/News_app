import 'package:news/Features/Domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({super.id, super.name, super.description, super.url});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'url': url};
  }
}
