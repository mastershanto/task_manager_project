// todo : m14 class-2:
// todo: a. implement completed
// todo: b.cancelled page and
// todo: c.update task progress bar and
//  todo: d. update after adding new task at same time

import 'package:flutter/material.dart';
import '../../../data/models/task_list_status_count_model.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/network_caller/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../ui_widgets/profile_summary_card.dart';
import '../../ui_widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({
    super.key,
    /*required this.task*/
  });

  // final Task task;
  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {

  bool getProgressTaskInProgress = false;

  TaskListModel taskListModel=TaskListModel();

  Future<void> getProgressTaskList() async {
    if (mounted) {
      setState(() {
        getProgressTaskInProgress = true;
      });
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getProgressTasks);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    if (mounted) {
      setState(() {
        getProgressTaskInProgress = false;
      });
    }
  }


  @override
  void initState() {
    getProgressTaskList();

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
                visible: getProgressTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 5,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: (){
                          getProgressTaskList();
                        },
                        showProgress: (inProgress){
                          getProgressTaskInProgress=inProgress;
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
