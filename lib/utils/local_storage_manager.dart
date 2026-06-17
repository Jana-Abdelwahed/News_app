import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageManager {
  static const String _newsBoxName = 'cached_news_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_newsBoxName);
  }

  static Future<void> cacheArticles(
    String categoryKey,
    List<dynamic> rawArticlesJson,
  ) async {
    var box = Hive.box(_newsBoxName);
    await box.put('articles_$categoryKey', rawArticlesJson);
  }

  static List<dynamic>? getCachedArticles(String categoryKey) {
    var box = Hive.box(_newsBoxName);
    return box.get('articles_$categoryKey');
  }
}
