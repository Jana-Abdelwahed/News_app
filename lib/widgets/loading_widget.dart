import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Center(child: CircularProgressIndicator(
      color:themeProvider.isLight()?AppColors.black_color:AppColors.white_color ,
    ),);
  }
}
