//Todo: http and Dio used for connecting project with API Internet
//todo for Assignment:  Email validation by RegEx
//todo for Assignment:
// validate the mobile no with 11 digits

import 'package:flutter/material.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../ui_widgets/body_background.dart';
import '../ui_widgets/snack_message.dart';
import 'forgot_password_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BodyBackground(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Join with us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      //todo: validate email address with regex
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your valid email!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your first name!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "First name ",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your last name!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Last name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      //todo: validate the mobile no with 11 digits
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your mobile number!";
                        }
                        if (value!.length != 11) {
                          return "Mobile number must be 11 digit.!";
                        }
                        if (int.tryParse(value) == null) {
                          return "Mobile number must be numeric(a-z or A-Z).!";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Mobile",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter your valid password!";
                        }

                        if (value!.length < 6) {
                          return "Enter password at least 6 letters!";
                        }
                        return null;
                      },
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
                        visible: _signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              _signUp();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()));
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
                        const Text("have an account?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sing In",
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

  Future<void> _signUp() async {
    if (_globalFormKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          _signUpInProgress = true;
        });
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "email": _emailTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
      });

      if (mounted) {
        setState(() {
          _signUpInProgress = false;
        });
      }

      if (response.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(context, "Account has been created! Please login");
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Account creation failed! Try again.",
              isError: true);
        }
      }

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //         const PinVerificationScreen()),
      //         (context) => false);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _passwordTEController.dispose();
    _passwordTEController.dispose();
  }
}
