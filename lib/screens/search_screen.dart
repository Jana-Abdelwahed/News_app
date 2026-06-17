import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../api/api_manager.dart';
import '../models/news_response.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import '../widgets/news_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<Article> articles = [];

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore &&
          query.isNotEmpty) {
        loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              child: TextField(
                style: TextStyle(
                  color: AppColors.grey_color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.grey_color,
                textInputAction: TextInputAction.search,
                autofocus: true,
                onChanged: (text) {
                  setState(() {
                    query = text;
                  });


                  page = 1;
                  hasMore = true;
                  articles.clear();
                  searchNews();
                },
                decoration: InputDecoration(
                  hintText: 'search'.tr(),
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        query = '';
                        page = 1;
                        hasMore = true;
                        articles.clear();
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.grey_color),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.grey_color),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.grey_color),
                  ),
                ),
              ),
            ),


            Expanded(
              child: articles.isEmpty && isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                controller: scrollController,
                itemCount: articles.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < articles.length) {
                    return NewsItem(article: articles[index]);
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.02,
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchNews() async {
    if (query.isEmpty) return;

    isLoading = true;
    setState(() {});

    try {
      var response = await ApiManager.searchNews(query, page);
      final newArticles = response.articles ?? [];

      if (page == 1) {
        articles = newArticles;
      } else {
        articles.addAll(newArticles);
      }

      if (newArticles.isEmpty) {
        hasMore = false;
      }
    } catch (e) {
      hasMore = false;
    }

    isLoading = false;
    setState(() {});
  }

  Future<void> loadMore() async {
    page++;
    await searchNews();
  }
}