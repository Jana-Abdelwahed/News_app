import 'package:flutter/material.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Presentation/pages/article_bottom_sheet.dart';

class NewsItem extends StatelessWidget {
  final ArticleEntity article;

  const NewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          article_bottom_sheet.show(context, article);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(
                article.urlToImage!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                article.description ?? '',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
