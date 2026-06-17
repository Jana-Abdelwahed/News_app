import 'package:flutter/material.dart';
import 'package:news/screens/future_widgets/source_future_widget.dart';
import 'filter/models/category_model.dart';
class HomeScreen extends StatelessWidget {
   final CategoryModel category;
   final String query;
  const HomeScreen({super.key,required this.category,required this.query});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SourceFutureWidget(category:category,query:query , ),
    );
  }
}
