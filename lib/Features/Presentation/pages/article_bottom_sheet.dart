import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/Features/Domain/entities/article_entity.dart';
import 'package:news/Features/Presentation/pages/web_view_screen.dart';
import 'package:news/core/prefs/theme_provider.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_size.dart';
import 'package:provider/provider.dart';

class article_bottom_sheet extends StatelessWidget {
  final ArticleEntity article;

  const article_bottom_sheet({super.key, required this.article});

  static void show(BuildContext context, ArticleEntity article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => article_bottom_sheet(article: article),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark();
    final theme = Theme.of(context);
    final width = context.width;
    final height = context.height;

    final modalBgColor = isDark ? AppColors.white_color : AppColors.black_color;
    final textColor = isDark ? AppColors.black_color : AppColors.white_color;
    final buttonBgColor = isDark
        ? AppColors.black_color
        : AppColors.white_color;
    final buttonTextColor = isDark
        ? AppColors.white_color
        : AppColors.black_color;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.04,
        right: width * 0.04,
        bottom: MediaQuery.of(context).viewInsets.bottom + height * 0.03,
      ),
      child: Material(
        color: modalBgColor,
        borderRadius: BorderRadius.circular(width * 0.06),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.04),
                  child: Image.network(
                    article.urlToImage!,
                    height: height * 0.22,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: height * 0.22,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              SizedBox(height: height * 0.015),
              Text(
                article.content ?? article.description ?? '',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: textColor,
                  fontSize: width * 0.035,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height * 0.02),
              if (article.url != null && article.url!.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBgColor,
                      foregroundColor: buttonTextColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.04),
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
                        fontSize: width * 0.04,
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
