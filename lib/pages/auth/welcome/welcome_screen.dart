import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../service/helper.dart';
import '../../auth/login/login_screen.dart';
import '../../auth/signUp/sign_up_screen.dart';
import '../../auth/welcome/welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: alabaster,
            appBar: AppBar(
              backgroundColor: lightDark,
              title: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  // width: 200.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            body: BlocListener<WelcomeBloc, WelcomeInitial>(
              listener: (context, state) {
                switch (state.pressTarget) {
                  case WelcomePressTarget.login:
                    push(context, const LoginScreen());
                    break;
                  case WelcomePressTarget.signup:
                    push(context, const SignUpScreen());
                    break;
                  default:
                    break;
                }
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const LoginScreen(),
                ),
              ),
            ),
            bottomSheet: Container(
              alignment: Alignment.bottomCenter,
              height: 70,
              color: alabaster,
              child: TextButton(
                onPressed: () {
                  context.read<WelcomeBloc>().add(SignupPressed());
                },
                style: TextButton.styleFrom(
                  backgroundColor: lightDark,
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(colorPrimary)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
