import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/models/task_list_model.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/data/utility/urls.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';
import 'package:task_manager_pro/ui/widget/task_item_card.dart';

class CancelTask extends StatefulWidget {
  const CancelTask({super.key});

  @override
  _CancelTaskState createState() => _CancelTaskState();
}

class _CancelTaskState extends State<CancelTask> {
  List<String> taskProgressTitle = ["New", "In Progress", "Complected"];
  bool getNewTaskInProgress = false;
  bool getTaskSummaryCountInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.cancelledTaskList,
    );
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),

            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      onStatusChange: () {
                        getNewTaskList();
                      },
                      task: taskListModel.taskList![index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
