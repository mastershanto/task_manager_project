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

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({
    super.key,
    /*required this.task*/
  });

  // final Task task;
  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {

  bool getCompletedTaskInProgress = false;

  TaskListModel taskListModel=TaskListModel();

  Future<void> getCompletedTaskList() async {
    if (mounted) {
      setState(() {
        getCompletedTaskInProgress = true;
      });
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompletedTasks);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    if (mounted) {
      setState(() {
        getCompletedTaskInProgress = false;
      });
    }
  }


  @override
  void initState() {
    getCompletedTaskList();

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
                visible: getCompletedTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getCompletedTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 5,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: (){
                          getCompletedTaskList();
                        },
                        showProgress: (inProgress){
                          getCompletedTaskInProgress=inProgress;
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