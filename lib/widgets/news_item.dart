import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/news_response.dart';
import '../providers/theme_provider.dart';
import '../screens/web_view_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import 'loading_widget.dart';

class NewsItem extends StatefulWidget {
  final Article article;
  const NewsItem({super.key,required this.article});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    var height=context.height;
    var width=context.width;
    var themeProvider=Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: (){
       appBottomSheet(themeProvider,height,width);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.01,
          vertical: height*0.01
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width*0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: themeProvider.isLight()?AppColors.white_color:AppColors.black_color,
          border: Border.all(
            color: themeProvider.isLight()?Colors.black:Colors.white,
          )
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:CachedNetworkImage(
                imageUrl:widget.article.urlToImage??'' ,
                placeholder: (context, url) => LoadingWidget(),
                errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.grey_color),
              ),
            ),
            SizedBox(height: height*0.02,),
            Text(widget.article.title??'',style: Theme.of(context).textTheme.labelSmall,),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('${'by'.tr()} :${widget.article.author??'unknown'.tr()}',style: AppStyles.medium12Grey,)),
                Text( widget.article.publishedAt == null
                    ? ''
                    : timeago.format(DateTime.parse(widget.article.publishedAt!),
                locale: context.locale.languageCode
                ),
                  style: AppStyles.medium12Grey,)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> appBottomSheet(ThemeProvider themeProvider,dynamic height,dynamic width){
    return showModalBottomSheet(
      backgroundColor: themeProvider.isLight()?AppColors.black_color:AppColors.white_color,
        context: context, builder: (BuildContext context) {
      var themeProvider=Provider.of<ThemeProvider>(context,listen: false);
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: width*0.01,
            vertical: height*0.01
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width*0.02,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: themeProvider.isLight()?AppColors.black_color:AppColors.white_color,
        ),
        child: Column(
            children: [
        ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:CachedNetworkImage(
          imageUrl:widget.article.urlToImage??'' ,
          placeholder: (context, url) => LoadingWidget(),
          errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.grey_color),
        ),
              ),
              SizedBox(height: height*0.02,),
              Expanded(child: Text(widget.article.description??'',style: Theme.of(context).textTheme.displayMedium,)),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: WidgetStateProperty.all(themeProvider.isLight()?AppColors.white_color:AppColors.black_color),
                       padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                         horizontal: width*0.05,
                         vertical: height*0.025
                       )),
                       shape:WidgetStatePropertyAll(RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16)
                       ))
                     ),
                     onPressed: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (_) => WebViewScreen(url: widget.article.url??''),
                         ),
                       );

                     }, child: Text('view_article'.tr(),
                 style: Theme.of(context).textTheme.displaySmall,
                 )),
               )
              ]));
    });
  }
}
