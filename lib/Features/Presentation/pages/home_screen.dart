import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Presentation/cubit/newsCupit.dart';
import 'package:news/Features/Presentation/pages/filter/models/category_model.dart';
import 'package:news/core/services/service_locator.dart';
import 'package:news/core/widgets/source_tab_bar.dart';

import '../widgets/news_future_widget.dart' show NewsListViewWidget;

class HomeScreen extends StatelessWidget {
  final CategoryModel category;
  final String query;

  const HomeScreen({super.key, required this.category, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsCubit>()..fetchSources(category.id),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SourceTabBar(),
              const Expanded(child: NewsListViewWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
