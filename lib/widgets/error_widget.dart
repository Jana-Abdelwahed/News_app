import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
class ErrorPopUpWidget extends StatelessWidget {
final String message;
final VoidCallback onPressed;
  const ErrorPopUpWidget({super.key,required this.message,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeProvider.isLight()?AppColors.black_color:AppColors.white_color
          ),),
          ElevatedButton(onPressed:onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.grey_color)
          ),
            child: Text('try_again'.tr(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isLight()?AppColors.black_color:AppColors.white_color
              ),),
          )
        ],
      ),
    );
  }
}
