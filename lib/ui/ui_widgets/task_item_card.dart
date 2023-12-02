import 'package:flutter/material.dart';

import '../../data/models/task.dart';


class TaskItemCard extends StatelessWidget {
   const TaskItemCard({
    super.key,required this.task
  });

  final Task task;

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
              task.title??"",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(task.description??"",),
            Text("Date: ${task.createdDate??""}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Chip(
                  label: Text("New"),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),

                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
