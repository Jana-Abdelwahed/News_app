import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Features/Data/models/articleModel.dart';
import 'package:news/Features/Data/models/sourceModel.dart';
import 'package:news/core/api/api_constants.dart';
import 'package:news/core/api/end_points.dart';

abstract class NewsRemoteDataSource {
  Future<List<SourceModel>> getSources(String categoryId);
  Future<List<ArticleModel>> getArticles(
    String sourceId,
    String query,
    int page,
  );
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SourceModel>> getSources(String categoryId) async {
    final uri = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.api_key,
      'category': categoryId,
    });

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List sourcesJson = json['sources'] ?? [];
      return sourcesJson.map((s) => SourceModel.fromJson(s)).toList();
    } else {
      throw Exception(json['message'] ?? 'Failed to fetch sources');
    }
  }

  @override
  Future<List<ArticleModel>> getArticles(
    String sourceId,
    String query,
    int page,
  ) async {
    final uri = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.api_key,
      'sources': sourceId,
      'q': query,
      'page': page.toString(),
      'pageSize': '10',
    });

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List articlesJson = json['articles'] ?? [];
      return articlesJson.map((a) => ArticleModel.fromJson(a)).toList();
    } else {
      throw Exception(json['message'] ?? 'Failed to fetch articles');
    }
  }
}
