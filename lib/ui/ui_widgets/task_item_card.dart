
import 'package:flutter/material.dart';
import '../../data/models/task.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';


enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard(
      {super.key,
      required this.task,
      required this.onStatusChange,
      required this.showProgress});

  final Task task;

  final VoidCallback onStatusChange;

  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? "", status));

    if (response.isSuccess) {
      widget.onStatusChange();
    }

    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              widget.task.description ?? "",
            ),
            Text("Date: ${widget.task.createdDate ?? ""}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Chip(
                  label: Text("New"),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: const Icon(Icons.edit)),
                    // IconButton(
                    //     onPressed: () {}, icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: /* ListView.builder(
                itemCount: TaskStatus.values.length,
                itemBuilder:(context,index){
                  return ListTile(
                    title: Text(
                      "${TaskStatus.values[index]}"
                    ),
                  );
                }) ,*/
                Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
