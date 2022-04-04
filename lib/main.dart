import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/initial/welcome_screen.dart';
import 'package:botp_auth/core/auth/modules/signin_current/screens/signin_current_screen.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:botp_auth/core/session/session_state.dart';
import 'package:botp_auth/modules/app/screens/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:botp_auth/configs/themes/app_themes.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/configs/routes/routes.dart';
import 'package:fluro/fluro.dart';

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
    // (not used) Initiate backend services e.g AWS, Firebase
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
                child: const AppNavigator())));
  }
}

// Main navigation
class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(pages: [
        if (state is UnknownSessionState) const MaterialPage(child: Scaffold()),
        if (state is UnauthenticatedSessionState)
          const MaterialPage(child: WelcomeScreen()),
        if (state is ExpiredSessionState)
          const MaterialPage(child: SignInCurrentScreen()),
        if (state is AuthenticatedSessionState)
          const MaterialPage(child: MainAppScreen()),
      ], onPopPage: (route, result) => route.didPop(result));
    });
  }
}
