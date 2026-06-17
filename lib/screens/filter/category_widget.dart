import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/filter/models/category_model.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import 'dart:ui' as ui;
class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final int index;
  const CategoryWidget({super.key,required this.category,required this.index});
  @override
  Widget build(BuildContext context) {
    var height=context.height;
    var width=context.width;
    var themeProvider=Provider.of<ThemeProvider>(context);
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;
    final showForwardArrow = isRtl ? !index.isEven : index.isEven;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.02),
      height: height*0.25,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(category.image),fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(24),
      ),
    child: Stack(
      alignment:index.isEven?Alignment.centerRight:Alignment.centerLeft ,
    children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.1),
        child: Column(
          children: [
            SizedBox(height: height*0.04,),
            Text(category.title,style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 30)),
            Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*0.04),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey_color,
                  borderRadius: BorderRadius.circular(84)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: width*0.02,
                  textDirection: index.isEven?ui.TextDirection.ltr:ui.TextDirection.rtl,
                  children: [
                    SizedBox(width: width*0.01,),
                    Text('view_all'.tr(),style: Theme.of(context).textTheme.headlineLarge,),
                    CircleAvatar(
                        backgroundColor:themeProvider.isLight()?AppColors.white_color:AppColors.black_color ,
                        child: Icon(showForwardArrow? Icons.arrow_forward_ios:Icons.arrow_back_ios,size: 16,
                        color: AppColors.grey_color,
                        ))
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    ],
    ),
    );
  }
}
