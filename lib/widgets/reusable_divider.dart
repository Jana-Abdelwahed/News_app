import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class ReusableDivider extends StatelessWidget {
  const ReusableDivider({super.key});

  @override
  Widget build(BuildContext context) {
    var width=context.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.02),
      child: Divider(
        color: AppColors.white_color,
        thickness: 2,
        endIndent: width*0.04,
        indent: width*0.04,
      ),
    );
  }
}
