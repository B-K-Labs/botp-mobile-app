import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/app/screens/app_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_other_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //     automaticallyImplyLeading: true,
        //     backgroundColor: AppColors.whiteColor,
        //     elevation: 0.0,
        //     leading: IconButton(
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: AppColors.blackColor,
        //       ),
        //       onPressed: () => Navigator.pop(context, false),
        //     )),
        body: SignUpBody());
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController _passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  bool _isLoading = false;
  // Sign up function
  signUp(password) async {
    print("Posting data");
    Map data = {'password': password};
    final response = await post(urlSignUp, data);
    setState(() {
      _isLoading = false;
    });
    print(response);
    if (response != null) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Done! Check your terminal")));
    } else {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("ERROR :<<<")));
    }
  }

  // On submit
  onSubmitSignUp() {
    print(_isLoading);
    if (_isLoading) {
      print("Please wait for response: sign up request");
      return;
    }
    if (_passwordController.text.isEmpty) {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Please enter password")));
      return;
    }
    signUp(_passwordController.text);
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) {
    //       return const MainAppScreen();
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(height: 28.0),
        const SizedBox(height: 72.0),
        Text("Create new account",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: AppColors.primaryColor)),
        const SizedBox(height: 96.0),
        Text('Password', style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 12.0),
        AppPasswordInputField(controller: _passwordController),
        const SizedBox(height: 36.0),
        AppNormalButton(
          text: "Create account",
          press: onSubmitSignUp,
          primary: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
        ),
        const SizedBox(height: 60.0),
        AppSubButton(
          text: "Import existing account",
          press: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const SignInOtherScreen();
              },
            ));
          },
          primary: AppColors.primaryColor,
        ),
      ],
    ));
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
