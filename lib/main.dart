import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_app/pages/auth/authentication_bloc.dart';
import 'package:tender_app/pages/loading_cubit.dart';
import '../constants.dart';
import 'pages/auth/launcherScreen/launcher_screen.dart';

void main() async {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => AuthenticationBloc()),
      RepositoryProvider(create: (_) => LoadingCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
        body: Container(
          color: const Color(colorPrimary),
          child: Center(
              child: Column(
            children: const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(height: 16),
              Text(
                'Failed to initialise firebase!',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          )),
        ),
      ));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: const Color(colorPrimary),
        child: const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
        ),
      );
    }

    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(colorPrimary),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(colorPrimary),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          snackBarTheme: const SnackBarThemeData(
              contentTextStyle: TextStyle(color: Colors.black)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(colorPrimary),
            brightness: Brightness.light,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          )),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade800,
          appBarTheme:
              const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
          snackBarTheme: const SnackBarThemeData(
              contentTextStyle: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(colorPrimary),
              brightness: Brightness.dark)),
      debugShowCheckedModeBanner: false,
      color: const Color(colorPrimary),
      home: LauncherScreen(),
      // home: const ChoicePage(),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }
}
