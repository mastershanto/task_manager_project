//todo: http and dio used for connecting project with api internet

import 'package:flutter/material.dart';
import '../../../data/models/task_count.dart';
import '../../../data/models/task_list_model.dart';
import '../../../data/models/task_list_status_count_model.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/network_caller/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../ui_widgets/profile_summary_card.dart';
import '../../ui_widgets/summary_card.dart';
import '../../ui_widgets/task_item_card.dart';
import 'add_new_tasks_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSummaryInProgress = false;

  TaskListModel taskListModel = TaskListModel();

  TaskCountSummaryListModel taskCountSummaryListModel =
  TaskCountSummaryListModel();

  Future<void> getTaskCountSummaryList() async {
    if (mounted) {
      setState(() {
        getTaskCountSummaryInProgress = true;
      });
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }

    if (mounted) {
      setState(() {
        getTaskCountSummaryInProgress = false;
      });
    }
  }

  Future<void> getNewTaskList() async {
    if (mounted) {
      setState(() {
        getNewTaskInProgress = true;
        getTaskCountSummaryList();
      });
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getNewTasks);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    if (mounted) {
      setState(() {
        getNewTaskInProgress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCountSummaryList();
    getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewTaskScreen()));
            },
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              const ProfileSummaryCard(),
              // const SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 16, right: 16),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         SummaryCard(
              //           count: 39,
              //           title: "New",
              //         ),
              //         SummaryCard(
              //           count: 39,
              //           title: "In Progress",
              //         ),
              //         SummaryCard(
              //           count: 39,
              //           title: "Completed",
              //         ),
              //         SummaryCard(
              //           count: 39,
              //           title: "Cancelled",
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Visibility(
                visible: getTaskCountSummaryInProgress ==
                    false /*&&
                (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                    false)*/
                ,
                replacement: const LinearProgressIndicator(),
                child: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: taskCountSummaryListModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount? taskCount =
                        taskCountSummaryListModel.taskCountList![index];
                        //todo: Fetch inProgress data,
                        //todo: Fetch completed data,
                        //todo: Fetch cancel Data
                        return FittedBox(
                          child: SummaryCard(
                            count: taskCount.sum,
                            title: taskCount.sId ?? "",
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Visibility(
                  visible: getNewTaskInProgress == false &&
                      (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                          false),
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 5,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: (){
                          getNewTaskList();
                        },
                        showProgress: (inProgress){
                          getNewTaskInProgress=inProgress;
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
            ],
          ),
        ));
  }
}