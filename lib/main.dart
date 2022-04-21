import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/repositories/history_repository.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/repositories/transaction_repository.dart';
import 'package:botp_auth/configs/environment/environment.dart';
import 'package:botp_auth/configs/themes/app_theme.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/configs/routes/routes.dart';
import 'package:fluro/fluro.dart';

void main() async {
  // Configuration from .env aka dotenv
  await Environment().initConfig();
  // google_fonts license registering
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // Accessing behind platforms e.g splashscreen, shared preferences
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Splash screens initialization
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // (dev) Clear user data
  await UserData.clearData();
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
    // (not used) Initiate backend services e.g AWS, Firebase
    // Remove splash screens
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        // All providers
        // * Why to provide repository outside the BLoC: https://stackoverflow.com/questions/68137041/flutter-bloc-why-are-repositories-declared-on-the-ui-and-not-the-backend
        providers: [
          RepositoryProvider(create: (context) => AuthenticationRepository()),
          RepositoryProvider(create: (context) => AuthenticatorRepository()),
          RepositoryProvider(create: (context) => TransactionRepository()),
          RepositoryProvider(create: (context) => HistoryRepository()),
          RepositoryProvider(create: (context) => SettingsRepository()),
        ],
        // Provider SessionBloc at the root for session management
        child: MultiBlocProvider(
            providers: [
              BlocProvider<SessionCubit>(
                  create: (context) => SessionCubit(
                      authenticationRepository:
                          context.read<AuthenticationRepository>())),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              // Themes
              theme: lightThemeData,
              darkTheme: darkThemeData,
              themeMode: ThemeMode.light,
              title: 'BOTP Authenticator',
              // Fluro routes generation
              onGenerateRoute: Application
                  .router.generator, // It would use the root path first i.e "/"
              // (not used anymore)
              // home: SessionScreen()
            )));
  }
}
