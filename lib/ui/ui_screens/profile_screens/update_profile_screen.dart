//Todo: http and Dio used for connecting project with API Internet

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/ui/ui_widgets/snack_message.dart';

import '../../../data/models/user_model.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/network_caller/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../controllers/auth_controller.dart';
import '../../ui_widgets/body_background.dart';
import '../../ui_widgets/profile_summary_card.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool updateProfileInProgress = false;

  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? "";
    _firstNameTEController.text = AuthController.user?.firstName ?? "";
    _lastNameTEController.text = AuthController.user?.lastName ?? "";
    _mobileTEController.text = AuthController.user?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const ProfileSummaryCard(
              enableOnTab: false,
            ),
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
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter your valid email!";
                            }
                            const pattern =
                                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

                            final regex = RegExp(pattern);
                            if (value!.isNotEmpty && !regex.hasMatch(value)) {
                              return "Enter email like tm@email.com";
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
                          controller: _firstNameTEController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your valid first name!";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your valid last name!";
                            }
                            return null;
                          },
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
                            child: Visibility(
                              visible: updateProfileInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateProfile();
                                    }
                                  },
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined)),
                            )),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

/*  Future<void> updateProfile() async {
    if (mounted) {
      setState(() {
        updateProfileInProgress = true;
      });
    }

    String photoInBase64;

    Map<String, dynamic> inputDate = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "email": _emailTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };



    if (_passwordTEController.text.isNotEmpty) {
      inputDate["password"] = _passwordTEController.text;
    }

    if(photo !=null){
      List<int> imageByte=await photo!.readAsBytes();

      photoInBase64= base64Encode(imageByte);

      inputDate["photo"]=photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputDate,
    );

    if (mounted) {
      setState(() {
        updateProfileInProgress = false;
      });
    }

    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
      ));

      if (mounted) {
        showSnackMessage(context, "Profile updating successfully!");
      }
    } else {
      if (mounted) {
        showSnackMessage(context, "Profile updating failed! try again.",
            isError: true);
      }
    }
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
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              child: Text(
                "Image",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50);
                if (image != null) {
                  if(mounted){
                    setState(() {
                      photo=image;
                    });
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Visibility(
                    visible: photo == null,
                    replacement: Text(photo?.name ?? ""),
                    child: const Text("Select a photo")),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Future<void> updateProfile() async {
    updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName" : _lastNameTEController.text.trim(),
      "email" : _emailTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }

    if (photo != null){
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          photo: photoInBase64 ?? AuthController.user?.photo
      ));
      if (mounted) {
        showSnackMessage(context, 'Update profile success!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed. Try again.');
      }
    }
  }

  Container photoPickerField(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.camera, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: const Text('Select a photo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
