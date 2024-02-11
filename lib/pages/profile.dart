import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_app/model/user.dart';
import 'package:tender_app/pages/home/profile_screen.dart';
import '../../../constants.dart';
import 'auth/authentication_bloc.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator();

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
  get imageList => null;

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.authState) {
              case AuthState.firstRun:
              case AuthState.authenticated:
              case AuthState.unauthenticated:
                break;
            }
          },
          builder: (context, state) =>
              ProfileScreen(user: state.user ?? User())),
    );
  }
}
