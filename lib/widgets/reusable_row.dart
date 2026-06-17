import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class ReusableRow extends StatelessWidget {
  final String picName;
  final String data;
  const ReusableRow({super.key, required this.picName, required this.data});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        spacing: width * 0.02,
        children: [
          Image.asset(picName),
          Text(
            data,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white_color,
            ),
          ),
        ],
      ),
    );
  }
}
