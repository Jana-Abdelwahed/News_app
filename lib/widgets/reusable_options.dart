import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/prefs/theme_prefs.dart';
import 'package:news/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/app_size.dart';

class ReusableOptions1 extends StatelessWidget {
  final String data;
  const ReusableOptions1({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    var width=context.width;
    var height=context.height;
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.white_color
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.white_color
        ),),
            PopupMenuButton<String>(
              icon: Icon(
                Icons.arrow_drop_down_sharp,
                color: AppColors.white_color,
              ),
              onSelected: (value) {
                if(value=='light'){
                  themeProvider.changeTheme(ThemeMode.light);
                }else{
                  themeProvider.changeTheme(ThemeMode.dark);
                }
              },
              offset: const Offset(0, 40),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'light',
                  child: Text('light'.tr()),
                ),
                 PopupMenuItem(
                  value: 'dark',
                  child: Text('dark'.tr()),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
class ReusableOptions2 extends StatelessWidget {
  final String data;
  const ReusableOptions2({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    var width=context.width;
    var height=context.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: AppColors.white_color
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.white_color
            ),),
            PopupMenuButton<String>(
              icon: Icon(
                Icons.arrow_drop_down_sharp,
                color: AppColors.white_color,
              ),
              onSelected: (value) {
                if(value=='en'){
                  context.setLocale(Locale('en'));
                }else{
                  context.setLocale(Locale('ar'));
                }
              },
              offset: const Offset(0, 40),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'en',
                  child: Text('english'.tr()),
                ),
                PopupMenuItem(
                  value: 'ar',
                  child: Text('arabic'.tr()),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
