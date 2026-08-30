import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? url;

  const SourceEntity({this.id, this.name, this.description, this.url});

  @override
  List<Object?> get props => [id, name, url];
}
