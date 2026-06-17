import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/widgets/customized_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_size.dart';
import '../home_screen.dart';
import 'category_widget.dart';
import 'models/category_model.dart';
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  CategoryModel? selectedCategory;
  String query='';
  @override
  Widget build(BuildContext context) {
    var width=context.width;
    var height=context.height;
    var themeProvider=Provider.of<ThemeProvider>(context);
    var categoryList=CategoryModel.categories(themeProvider.isLight());
    return Scaffold(
      appBar:  AppBar(
        title: Text(selectedCategory==null?'home'.tr():selectedCategory!.id.tr(),style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 20),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'search_route',
            );
          }, icon: Icon(Icons.search,size: 30,))
        ],
      ),
      drawer:CustomizedDrawer(onTap: (){
        selectedCategory=null;
        Navigator.pop(context);
        setState(() {

        });
      },),
      body: selectedCategory==null?
       Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width*0.02,
          vertical: height*0.01,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: height*0.02,
            children: [
              Text('good_morning_message'.tr(),style: Theme.of(context).textTheme.headlineLarge,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                return GestureDetector(
                    onTap:(){
                      onTap(categoryList[index]);
                    } ,
                    child: CategoryWidget(category: categoryList[index],index: index,));
              },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.02,);
                  },
                  itemCount: categoryList.length)
            ],
          ),
        ),
      ):HomeScreen(category: selectedCategory??categoryList[0],query: query,),
    );
  }

  void onTap(CategoryModel newCategory){
    selectedCategory=newCategory;
    setState(() {

    });
  }
}
