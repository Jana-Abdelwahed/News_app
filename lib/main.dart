import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/Features/Presentation/pages/filter/filter_screen.dart';
import 'package:news/Features/Presentation/pages/search_screen.dart';
import 'package:news/core/prefs/theme_prefs.dart';
import 'package:news/core/prefs/theme_provider.dart';
import 'package:news/core/services/service_locator.dart';
import 'package:news/core/utils/app_routes.dart';
import 'package:news/core/utils/app_themes.dart';
import 'package:news/core/utils/local_storage_manager.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorageManager.init();
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  bool isDark = await ThemePrefs.getTheme() ?? false;
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return ThemeProvider(
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.filter_route,
      routes: {
        AppRoutes.filter_route: (context) => const FilterScreen(),
        AppRoutes.search_route: (context) => const SearchScreen(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
    );
  }
}
