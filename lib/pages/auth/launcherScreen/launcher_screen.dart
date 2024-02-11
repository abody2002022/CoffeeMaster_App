import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_app/pages/choice_page.dart';
import '../../../constants.dart';
import '../../../service/helper.dart';
import '../../home/profile_screen.dart';
import '../authentication_bloc.dart';
import '../onBoarding/data.dart';
import '../onBoarding/on_boarding_screen.dart';
import '../welcome/welcome_screen.dart';

//authunticated or not or on boarding
//نزل التطبيق ولا اول مرة
class LauncherScreen extends StatefulWidget {
  bool profile = false;
  LauncherScreen({profile});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      //BlocConsumer
      //بيخلي الحاجة تسمع من صفحة لي صفحة
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.firstRun:
              pushReplacement(
                  context,
                  OnBoardingScreen(
                    //first run
                    images: imageList,
                    titles: titlesList,
                    subtitles: subtitlesList,
                  ));
              break;
            case AuthState.authenticated:
              if (widget.profile) {
                push(context, ProfileScreen(user: state.user!));
                print('prof');
                return;
              } else {
                pushReplacement(context, const ChoicePage()); //choicepage
                print('repl');
              }

              break;
            case AuthState.unauthenticated:
              pushReplacement(context,
                  const WelcomeScreen()); //if notregistered go to authinticated module
              break;
          }
        },
        builder: (context, state) => const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
          ),
        ),
      ),
    );
  }
}
