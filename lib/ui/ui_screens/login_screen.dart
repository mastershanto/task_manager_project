//Todo: http and Dio used for connecting project with API Internet

//todo: we have to use jtw.oi website for testing JWT token


import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/user_model.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../ui_widgets/body_background.dart';
import '../ui_widgets/snack_message.dart';
import 'main_bottom_nev_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyBackground(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Get start with",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty /*?? true*/) {
                          return "Enter you valid email!";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (value) {
                        if (value!.isEmpty /*?? true*/) {
                          return "Enter you valid password!";
                        }
                        if (value.length < 6) {
                          return "Enter password at least 6 letters!";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );*/
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {

    if(!_formKey.currentState!.validate()){
      return; //different type use of form validation
    }
    if (mounted) {
      setState(() {
        _loginInProgress = true;
      });
    }
    NetworkResponse response = await NetworkCaller().postRequest(
      Urls.login,
      body: {
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text,
      },
    );

    if (mounted) {
      setState(() {
        _loginInProgress = false;
      });
    }

    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse["token"], UserModel.fromJson(response.jsonResponse["data"]));

      // Obtain shared preferences. Direct use of SharedPreferences
      /*SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.jsonResponse["token"]);*/

      _clearTextFields();
      if(mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainBottomNevScreen()));
      }

      if (mounted) {
        showSnackMessage(context, "You logged in successfully!");
      }
    } else {
      if (mounted) {
        if (response.statusCode == 401) {
          showSnackMessage(context, "Please, check your email/password.",
              isError: true);
        } else {
          showSnackMessage(context, "Login failed! try again.", isError: true);
        }
      }
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
