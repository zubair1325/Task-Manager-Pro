import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/models/task_list_model.dart';
import 'package:task_manager_pro/data/models/task_summary_count_model.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/data/utility/urls.dart';
import 'package:task_manager_pro/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';
import 'package:task_manager_pro/ui/widget/summary_card.dart';
import 'package:task_manager_pro/ui/widget/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<String> taskProgressTitle = ["New", "In Progress", "Complected"];
  bool getNewTaskInProgress = false;
  bool getTaskSummaryCountInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskSummaryCountModel taskSummaryCountModel = TaskSummaryCountModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.allTaskList,
    );
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskSummaryCount() async {
    getTaskSummaryCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.taskStatusCount,
    );
    print("0000000000000");
    print(response.statusCode);
    if (response.isSuccess) {
      taskSummaryCountModel = TaskSummaryCountModel.fromJson(
        response.jsonResponse!,
      );
    }
    getTaskSummaryCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskSummaryCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => AddNewTaskScreen(
              onTaskAdded: () => getNewTaskList(),
            )),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            Visibility(
              visible:
                  getTaskSummaryCountInProgress == false &&
                  (taskSummaryCountModel.taskCountList?.isNotEmpty ?? false),
              replacement: LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: taskSummaryCountModel.taskCountList?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: SummaryCard(
                        count: taskSummaryCountModel.taskCountList![index].sum
                            .toString(),
                        title: taskSummaryCountModel.taskCountList![index].sId
                            .toString(),
                      ),
                    );
                  },
                ),
              ),
            ),
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
