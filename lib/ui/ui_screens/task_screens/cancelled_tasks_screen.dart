//Todo: http and Dio used for connecting project with API Internet

import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../data/models/task_list_model.dart';
import '../../../data/models/task_list_status_count_model.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/network_caller/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../ui_widgets/profile_summary_card.dart';
import '../../ui_widgets/summary_card.dart';
import '../../ui_widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({
    super.key,
    /*required this.task*/
  });

  // final Task task;
  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {

  bool getCancelledTaskInProgress = false;

  TaskListModel taskListModel=TaskListModel();

  Future<void> getCancelledTaskList() async {
    if (mounted) {
      setState(() {
        getCancelledTaskInProgress = true;
      });
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCanceledTasks);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    if (mounted) {
      setState(() {
        getCancelledTaskInProgress = false;
      });
    }
  }


  @override
  void initState() {
    getCancelledTaskList();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: Visibility(
                visible: getCancelledTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getCancelledTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 5,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: (){
                          getCancelledTaskList();
                        },
                        showProgress: (inProgress){
                          getCancelledTaskInProgress=inProgress;
                          if(mounted){
                            setState(() {
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}