import 'package:botp_auth/configs/themes/app_themes.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/core/auth/cubit/auth_cubit.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/configs/routes/routes.dart';
import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signup/screens/signup_screen.dart';
import 'package:botp_auth/core/session/cubit/session_cubit.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main() async {
  // License registering for google_fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // For accessing behind platforms (e.g flashscreen, shared preferences)
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Splash screens initialization at later
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Run app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    // Routes setting up
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void initState() {
    super.initState();
    // Initiate other stuff e.g AWS, Firebase (we don't use that)
    // Remove splash screens
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BOTP Authenticator',
        theme: mapAppThemeData[AppTheme.light],
        // onGenerateRoute: Application.router.generator, // It would use root path first (i.e "/")
        home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (context) => AuthRepository())
            ],
            child: BlocProvider(
                create: (context) => SessionCubit(
                    authRepository: context.read<AuthRepository>()),
                child: BlocProvider(
                    create: (context) =>
                        AuthCubit(sessionCubit: context.read<SessionCubit>()),
                    child: const SignUpScreen()))));
  }
}
