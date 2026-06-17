import 'package:easy_localization/easy_localization.dart';

import '../../../utils/app_assets.dart';

class CategoryModel {
  String id;
  String title;
  String image;
  CategoryModel({required this.id,required this.title,required this.image});
  static List<CategoryModel> categories (bool isLight) {
     return [
       CategoryModel(id: 'general', title: 'general'.tr(), image: isLight ? AppAssets.darkGeneral : AppAssets.general),
       CategoryModel(id: 'business', title: 'business'.tr(), image: isLight ? AppAssets.darkBusiness : AppAssets.business),
       CategoryModel(id: 'sports', title: 'sports'.tr(), image: isLight ? AppAssets.darkSports : AppAssets.sports),
       CategoryModel(id: 'technology', title: 'technology'.tr(), image: isLight ? AppAssets.darkTechnology : AppAssets.technology),
       CategoryModel(id: 'entertainment', title: 'entertainment'.tr(), image: isLight ? AppAssets.darkEntertainment : AppAssets.entertainment),
       CategoryModel(id: 'health', title: 'health'.tr(), image: isLight ? AppAssets.darkHealth : AppAssets.health),
       CategoryModel(id: 'science', title: 'science'.tr(), image: isLight ? AppAssets.darkScience : AppAssets.science),
     ];
   }
}
