//Todo: http and Dio used for connecting project with API Internet

import 'package:flutter/material.dart';
// import 'package:flutter_practice_project/code_of_full_course/13.0_liveClass(1,2,3)_taskManagerApp_part-2_m13/ui/ui_widgets/body_background.dart';

import '../ui_widgets/profile_summary_card.dart';
import '../ui_widgets/summary_card.dart';
import '../ui_widgets/task_item_card.dart';


class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const ProfileSummaryCard(),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SummaryCard(
                        count: 39,
                        title: "New",
                      ),
                      SummaryCard(
                        count: 39,
                        title: "In Progress",
                      ),
                      SummaryCard(
                        count: 39,
                        title: "Completed",
                      ),
                      SummaryCard(
                        count: 39,
                        title: "Cancelled",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return const TaskItemCard();
                    },
                  )),
            ],
          ),
        ));
  }
}
