import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:power_file_view/power_file_view.dart';
import 'Screens/splash.dart';
import 'language/AppLocalizationsDelegate.dart';
import 'language/LocalConstant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PowerFileViewManager.initLogEnable(true, true);
  PowerFileViewManager.initEngine();
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyApp2State>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {

  Locale? _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    setState(() {
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      _locale = locale;
      setState(() {
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: Splash(),
      supportedLocales: const [
        Locale('en', ''),
        Locale('bn', ''),
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

    );
  }

}
