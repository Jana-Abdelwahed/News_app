import 'package:flutter/material.dart';
import 'package:news/models/source_response.dart';
import 'package:news/screens/future_widgets/news_future_widget.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_size.dart';
class SourceTabBar extends StatefulWidget {
 final SourceResponse sources;
 final String query;
  const SourceTabBar({super.key,required this.sources,required this.query});
  @override
  State<SourceTabBar> createState() => _SourceTabBarState();
}
class _SourceTabBarState extends State<SourceTabBar> {
 int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var height=context.height;
    return DefaultTabController(length:widget.sources.sources?.length??0
        , child:Column(
      children: [
        TabBar(
          onTap: (index){
            selectedIndex=index;
            setState(() {

            });
          },
            indicatorColor: themeProvider.isLight()?Colors.black:Colors.white,
            isScrollable: true,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            tabs:widget.sources.sources!.map((source) {
          return Text(source.name??'',
          style:selectedIndex==widget.sources.sources!.indexOf(source)?Theme.of(context).textTheme.labelMedium:Theme.of(context).textTheme.labelLarge, );
        },).toList()),
        SizedBox(height: height*0.02,),
        Expanded(child: NewsFutureWidget(source: widget.sources.sources![selectedIndex],query: widget.query,))
      ],
    ));
  }
}
