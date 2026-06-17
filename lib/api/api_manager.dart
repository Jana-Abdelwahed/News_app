import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/models/news_response.dart';
import 'package:news/models/source_response.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String categoryID) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.api_key,
        'category': categoryID,
      });
      var response = await http.get(url);
      var stringBody = response.body;
      var json = jsonDecode(stringBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNews(
    String sourceId,
    String language,
    String query,
  ) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.api_key,
        'sources': sourceId,
        'language': language,
        'q': query,
      });
      var response = await http.get(url);
      var bodyResponse = response.body;
      var json = jsonDecode(bodyResponse);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsByCategory(String categoryId) async {
    var url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.api_key,
      'category': categoryId,
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return NewsResponse.fromJson(json);
    } else {
      throw Exception('Failed to load news from server');
    }
  }

  static Future<NewsResponse> searchNews(String query, int page) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.api_key,
      'q': query,
      'pageSize': '10',
      'page': page.toString(),
    });

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
