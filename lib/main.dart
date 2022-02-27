import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main() {
  // License registering (for google_fonts)
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // Splash screen initialization
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Fluro routing initialization
  // final router = FluroRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextTheme _appTheme = TextTheme(
      bodyText1: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontSize: AppFontSizes.body1,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal)),
      bodyText2: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontSize: AppFontSizes.body2,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal)),
      headline4: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontSize: AppFontSizes.headline4,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal)),
      headline5: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontSize: AppFontSizes.headline5,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal)),
      headline6: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontSize: AppFontSizes.headline6,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal)),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOTP Authenticator',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: _appTheme,
      ),
      home: const AppInitialization(),
    );
  }
}

// App Initialization
class AppInitialization extends StatefulWidget {
  const AppInitialization({Key? key}) : super(key: key);

  @override
  _AppInitializationState createState() => _AppInitializationState();
}

class _AppInitializationState extends State<AppInitialization> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // Initialize the app (i.e load essential resources)
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const SignUpScreen();
  }
}
