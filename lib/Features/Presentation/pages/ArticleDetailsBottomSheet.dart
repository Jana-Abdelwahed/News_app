import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Presentation/pages/web_view_screen.dart';
import 'package:news/core/prefs/theme_provider.dart';
import 'package:provider/provider.dart';

class ArticleDetailsBottomSheet extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailsBottomSheet({super.key, required this.article});

  static void show(BuildContext context, ArticleEntity article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => ArticleDetailsBottomSheet(article: article),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark();
    final theme = Theme.of(context);

    final modalBgColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.black : Colors.white;
    final buttonBgColor = isDark ? Colors.black : Colors.white;
    final buttonTextColor = isDark ? Colors.white : Colors.black;

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      child: Material(
        color: modalBgColor,
        borderRadius: BorderRadius.circular(16.0),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    article.urlToImage!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              const SizedBox(height: 12.0),

              Text(
                article.content ?? article.description ?? '',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: textColor,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16.0),

              if (article.url != null && article.url!.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBgColor,
                      foregroundColor: buttonTextColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewScreen(url: article.url!),
                        ),
                      );
                    },
                    child: Text(
                      "view_article".tr(),
                      style: TextStyle(
                        color: buttonTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
