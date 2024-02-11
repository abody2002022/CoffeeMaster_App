import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_app/pages/home/profile_screen.dart';
import 'package:tender_app/pages/profile.dart';
import 'package:tender_app/service/dataManagers.dart';
import '../constants.dart';
import '../model/user.dart';
import 'auth/authentication_bloc.dart';
import 'menuPage.dart';
import 'orderPage.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});
  @override
  State<ChoicePage> createState() => ChoicePageState();
}

class ChoicePageState extends State<ChoicePage> {
  var dataManager = DataManager();
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("!!!!"); //why
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
        break;
      case 2:
        currentWidgetPage = const ProfileNavigator();
        break;
    }

    return Scaffold(
      drawer: Drawer(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: const [
              SizedBox(height: 30),
              Text(
                  "TEAM AI  \n Abdullah Mostafa \n Ramez Emad \n Mohammed Helmy \n Ahd Ahmad \n Mohmoud Mostafa \n Mohammed Awad \n Yara Magdy \n Malk Ahmad \n Ahmad Ramdan \n Ahmad Naser \n Ahmad Elhosiny"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: lightDark),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Coffee',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: 'Masters',
                    style: TextStyle(
                      color: Color(secondaryColor),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 24,
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FluidNavBar(
        // (1)
        icons: [
          // (2)
          FluidNavBarIcon(icon: Icons.coffee), // (3)
          FluidNavBarIcon(icon: Icons.shopping_cart_checkout_outlined), // (3)
          FluidNavBarIcon(icon: Icons.person), // (3)
        ],
        onChange: (index) => setState(() => selectedIndex = index), // (4)
      ),

      body: currentWidgetPage,
    );
  }
}
