import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Presentation/cubit/newsCupit.dart';
import 'package:news/Features/Presentation/cubit/newsState.dart';
import 'package:news/core/widgets/error_widget.dart';
import 'package:news/core/widgets/loading_widget.dart';
import 'package:news/core/widgets/news_item.dart';

class NewsListViewWidget extends StatelessWidget {
  const NewsListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state.status == NewsStatus.loading && state.articles.isEmpty) {
          return const LoadingWidget();
        }

        if (state.status == NewsStatus.failure && state.articles.isEmpty) {
          return ErrorPopUpWidget(
            message: state.errorMessage ?? "Error loading articles",
            onPressed: () {
              if (state.selectedSourceId != null) {
                context.read<NewsCubit>().fetchArticles(
                  sourceId: state.selectedSourceId!,
                  query: '',
                );
              }
            },
          );
        }

        return ListView.separated(
          itemCount: state.articles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return NewsItem(article: state.articles[index]);
          },
        );
      },
    );
  }
}
