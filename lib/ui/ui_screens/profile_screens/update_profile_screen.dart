//Todo: http and Dio used for connecting project with API Internet

import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';

import '../../ui_widgets/body_background.dart';
import '../../ui_widgets/profile_summary_card.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
   final TextEditingController _emailTEController=TextEditingController();
   final TextEditingController _firstNameTEController=TextEditingController();
   final TextEditingController _lastNameTEController=TextEditingController();
   final TextEditingController _mobileTEController=TextEditingController();
   // final TextEditingController _passwordTEController=TextEditingController();

  @override
  void initState() {
    _emailTEController.text=AuthController.user?.email??"";
    _firstNameTEController.text=AuthController.user?.firstName??"";
    _lastNameTEController.text=AuthController.user?.lastName??"";
    _mobileTEController.text=AuthController.user?.mobile??"";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const ProfileSummaryCard(enableOnLongTab: false,),
          Expanded(
            child: BodyBackground(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      photoPickerField(context),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
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
                        decoration: const InputDecoration(
                          hintText: "Mobile",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password (Optional)",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined))),
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
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                            },
                            child: const Text(
                              "Sign In",
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
        ],
      ),
    ));
  }

  Container photoPickerField(BuildContext context) {
    return Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: const BoxDecoration(
                                color:Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft:Radius.circular(8)
                                ),
                              ),
                              child: Text("Image",style: Theme.of(context).textTheme.titleSmall,),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Image url...",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
  }
}
