import 'package:donforget/db/db_helper.dart';
import 'package:donforget/services/theme_services.dart';
import 'package:donforget/ui/pages/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'ui/theme.dart';
import 'services/notification_services.dart';
import 'ui/pages/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());



}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light_theme,
      darkTheme: Themes.dark_theme,
      themeMode: ThemeServices().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}
