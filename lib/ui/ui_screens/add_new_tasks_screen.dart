//Todo: http and Dio used for connecting project with API Internet

import 'package:flutter/material.dart';
import 'package:task_manager_project/data/network_caller/network_response.dart';
import 'package:task_manager_project/ui/ui_widgets/snack_message.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/utility/urls.dart';
import '../ui_widgets/body_background.dart';
import '../ui_widgets/profile_summary_card.dart';

// import 'forgot_password_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _createTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BodyBackground(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileSummaryCard(
                enableOnLongTab: false,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Add New Task",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _subjectTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return "Enter any the subject of  your task!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Subject",
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _descriptionTEController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return "Enter the description of  your task!";
                            }
                            return null;
                          },
                          maxLines: 8,
                          decoration: const InputDecoration(
                            hintText: "Description",
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(

                          ///todo: How to show post Request headers time limit
                            width: double.infinity,
                            child: Visibility(
                              visible: _createTaskInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    createTask();
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
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        _createTaskInProgress = true;
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New",
      });

      if (mounted) {
        _createTaskInProgress = false;
      }

      if (response.isSuccess) {
        _clearTextFields();

        if (mounted) {
          showSnackMessage(context, "New task added successfully! ",
              isError: false);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Create new task failed! try again.",
              isError: true);
        }
      }
    }
  }

  void _clearTextFields() {
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();

    super.dispose();
  }
}
