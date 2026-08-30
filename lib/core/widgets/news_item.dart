import 'package:flutter/material.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';

class NewsItem extends StatelessWidget {
  final ArticleEntity article;

  const NewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            Image.network(
              article.urlToImage!,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              article.description ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
