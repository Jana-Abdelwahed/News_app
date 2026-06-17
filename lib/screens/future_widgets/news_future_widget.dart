import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/models/news_response.dart';
import 'package:news/models/source_response.dart';
import 'package:news/widgets/loading_widget.dart';
import 'package:news/widgets/news_item.dart';

import '../../utils/app_size.dart';
import '../../widgets/error_widget.dart';
import '../filter/news_repository.dart';

class NewsFutureWidget extends StatefulWidget {
  final Source source;
  final String query;

  const NewsFutureWidget({
    super.key,
    required this.source,
    required this.query,
  });

  @override
  State<NewsFutureWidget> createState() => _NewsFutureWidgetState();
}

class _NewsFutureWidgetState extends State<NewsFutureWidget> {
  late Future<List<Article>> articlesFuture;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  @override
  void didUpdateWidget(covariant NewsFutureWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id ||
        oldWidget.query != widget.query) {
      _loadArticles();
    }
  }

  void _loadArticles() {
    articlesFuture = NewsRepository.fetchArticles(
      widget.source.id ?? '',
      widget.query,
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return FutureBuilder<List<Article>>(
      future: articlesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const LoadingWidget();
        }

        if (snapshot.hasError || (snapshot.hasData && snapshot.data!.isEmpty)) {
          return ErrorPopUpWidget(
            message: "something_went_wrong".tr(),
            onPressed: () {
              setState(() {
                _loadArticles();
              });
            },
          );
        }

        final articles = snapshot.data ?? [];

        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          itemCount: articles.length,
          separatorBuilder: (context, index) => SizedBox(height: height * 0.02),
          itemBuilder: (context, index) {
            return NewsItem(article: articles[index]);
          },
        );
      },
    );
  }
}
