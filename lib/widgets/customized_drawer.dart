import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/widgets/reusable_divider.dart';
import 'package:news/widgets/reusable_options.dart';
import 'package:news/widgets/reusable_row.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_size.dart';

class CustomizedDrawer extends StatefulWidget {
 final VoidCallback? onTap;
  const CustomizedDrawer({super.key,required this.onTap});

  @override
  State<CustomizedDrawer> createState() => _CustomizedDrawerState();
}

class _CustomizedDrawerState extends State<CustomizedDrawer> {
  @override
  Widget build(BuildContext context) {
    var height=context.height;
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Column(
        spacing: height*0.02,
        children: [
          Container(
            height: height*0.27,
            alignment: Alignment.center,
            color: AppColors.white_color,
            child: Text('news_app'.tr(),style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black_color
            ),),
          ),
          GestureDetector(
              onTap: widget.onTap,
              child: ReusableRow(picName: AppAssets.homeIcon, data: 'go_to_home'.tr())),
          ReusableDivider(),
          ReusableRow(picName: AppAssets.themeIcon, data: 'theme'.tr()),
          ReusableOptions1(data:themeProvider.returnText(),),
          ReusableDivider(),
          ReusableRow(picName: AppAssets.languageIcon, data: 'language'.tr()),
          ReusableOptions2(data: getLangText(), ),
        ],
      ),
    );
  }
  String getLangText(){
   return context.locale.languageCode=='en'?'english'.tr():'arabic'.tr();
  }
}
