import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/ui_screens/main_bottom_nev_screen.dart';
import '../ui_widgets/body_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLongin();
  }

  void goToLongin() async {
    final isLoggedIn = await AuthController.checkAuthState();

    //User fo direct SharedPreferences
    /*SharedPreferences prefs= await SharedPreferences.getInstance();
    String? token=prefs.getString("token");*/
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return isLoggedIn
            ? const MainBottomNevScreen()
            : const LoginScreen(); /*token==null? const LoginScreen():const MainBottomNevScreen()*/
      }), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyBackground(
          child: Center(
            child: /*Image.asset("assets/site.jpg"),*/
                SvgPicture.asset(
              "assets/logo.svg",
              width: 120,
            ),
          ),
        ),
      ),
    );
  }
}
