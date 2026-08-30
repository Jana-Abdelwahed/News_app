import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Presentation/cubit/newsCupit.dart';
import 'package:news/Features/Presentation/cubit/newsState.dart';

class SourceTabBar extends StatelessWidget {
  const SourceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state.sources.isEmpty) {
          return const SizedBox.shrink();
        }

        return DefaultTabController(
          length: state.sources.length,
          child: TabBar(
            isScrollable: true,
            onTap: (index) {
              final selectedSource = state.sources[index];
              if (selectedSource.id != null) {
                context.read<NewsCubit>().fetchArticles(
                  sourceId: selectedSource.id!,
                  query: '',
                );
              }
            },
            tabs: state.sources
                .map((source) => Tab(text: source.name ?? ''))
                .toList(),
          ),
        );
      },
    );
  }
}
