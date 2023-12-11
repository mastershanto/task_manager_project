
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../ui_screens/profile_screens/login_screen.dart';
import '../ui_screens/profile_screens/update_profile_screen.dart';

///todo: Make the ProfileSummaryCard as Stateful Widget
class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({super.key, this.enableOnTab = true});

  final bool enableOnTab;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {

  @override
  Widget build(BuildContext context) {
    
    Uint8List imageBytes = const Base64Decoder().convert(AuthController.user?.photo??"");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ListTile(
          onTap: () {
            if (widget.enableOnTab == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ),
              );
            }
          },
          tileColor: Colors.green,
          leading: CircleAvatar(

            child: AuthController.user?.photo == null
                ? const Icon(Icons.person)
                : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.memory(imageBytes)),
          ),
          title: Text(
            fullName,
            style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(AuthController.user?.email ?? "",
              style: const TextStyle(color: Colors.white)),
          trailing: IconButton(
            onPressed: () {
              // showDialog<void>(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return logoutAndEditDialogBar(context);
              //   },
              // );

              AuthController.clearAuthData();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(
              // Icons.more_vert,
              Icons.logout,
              size: 35,
            ),
// - icon: const Icon(Icons.logout),),
          )),
    );
  }

  // SimpleDialog logoutAndEditDialogBar(context) {
  String get fullName {
    return "${AuthController.user?.firstName ?? ""} ${AuthController.user?.lastName ?? ""}";
  }
}
