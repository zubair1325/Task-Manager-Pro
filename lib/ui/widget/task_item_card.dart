import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/models/task.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/utility/urls.dart';

enum TaskStatus { New, Progress, Complected, Cancel }

class TaskItemCard extends StatefulWidget {
  final Task? task;
  final VoidCallback onStatusChange;
  const TaskItemCard({super.key, this.task, required this.onStatusChange});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    final response = await NetworkCaller().getRequest(
      Urls.updateTaskStatus(widget.task!.sId ?? "", status),
    );
    if (response.isSuccess) {
      widget.onStatusChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              widget.task!.title ?? ' ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task!.description ?? " "),
            Text(widget.task!.createdDate ?? " "),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task!.status ?? ' ',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModal();
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
            title: Text(e.name.toString()),
            onTap: () {
              updateTaskStatus(e.name);
              Navigator.pop(context);
            },
          ),
        )
        .toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) {
        return AlertDialog(
          title: Text("Update Status"),
          content: Column(mainAxisSize: MainAxisSize.min, children: items),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
