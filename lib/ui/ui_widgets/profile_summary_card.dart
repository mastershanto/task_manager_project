import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/ui_screens/login_screen.dart';
import '../ui_screens/update_profile_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
   const ProfileSummaryCard({super.key, this.enableOnLongTab = true});

   final bool enableOnLongTab;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: () {
          if (widget.enableOnLongTab == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              ),
            );
          }
        },
        tileColor: Colors.green,
        leading: const CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person),
          ),
        ),
        title: Text(fullName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(AuthController.user?.email ?? "",
            style: const TextStyle(color: Colors.white)),
        trailing: IconButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return logoutAndEditDialogBar(context);
              },
            );
          },
          icon: const Icon(
            Icons.more_vert,
            size: 40,
          ),
// - icon: const Icon(Icons.logout),),
        ));
  }

  SimpleDialog logoutAndEditDialogBar(context) {
    return SimpleDialog(
      title: const Text('Options'),
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        ListTile(
          onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen(),
                  )
              );

          },
          leading: const Icon(Icons.edit),
          title: const Text(
            "Update Profile",
            style: TextStyle(color: Colors.green),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListTile(
          onTap: () {
            AuthController.clearAuthData();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);

          },
          leading: const Icon(Icons.logout),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
          },
          trailing: const Text(
            "Close",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  String get fullName{
    return "${AuthController.user?.firstName??""} ${AuthController.user?.lastName ??""}";
  }
}
