import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/models/source_response.dart';
import 'package:news/screens/filter/models/category_model.dart';
import 'package:news/screens/filter/news_repository.dart';
import 'package:news/widgets/error_widget.dart';
import 'package:news/widgets/loading_widget.dart';
import 'package:news/widgets/source_tab_bar.dart';

class SourceFutureWidget extends StatefulWidget {
  final CategoryModel category;
  final String query;

  const SourceFutureWidget({
    super.key,
    required this.category,
    required this.query,
  });

  @override
  State<SourceFutureWidget> createState() => _SourceFutureWidgetState();
}

class _SourceFutureWidgetState extends State<SourceFutureWidget> {
  late Future<List<Source>> sourcesFuture;

  @override
  void initState() {
    super.initState();
    _loadSources();
  }

  @override
  void didUpdateWidget(covariant SourceFutureWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category.id != widget.category.id) {
      _loadSources();
    }
  }

  void _loadSources() {
    sourcesFuture = NewsRepository.fetchSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: sourcesFuture,
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
                _loadSources();
              });
            },
          );
        }

        final sourceResponse = SourceResponse(
          status: "ok",
          sources: snapshot.data,
        );

        return SourceTabBar(sources: sourceResponse, query: widget.query);
      },
    );
  }
}
