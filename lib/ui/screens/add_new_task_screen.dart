import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/data/utility/urls.dart';
import 'package:task_manager_pro/ui/screens/new_task_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';
import 'package:task_manager_pro/ui/widget/sanck_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, this.onTaskAdded});

  final VoidCallback? onTaskAdded;

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ProfileSummaryCard(),
              Expanded(
                child: BodyBackground(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 32),
                          Center(
                            child: Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _subjectTEController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(hintText: "title"),
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Title is required!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            maxLines: 8,
                            controller: _descriptionTEController,

                            decoration: InputDecoration(
                              hintText: "description",
                            ),
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Description is required!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Visibility(
                            visible: _createTaskInProgress == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: createTask,
                              child: Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_globalKey.currentState!.validate()) {
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createTask,
        body: {
          "title": _subjectTEController.text.trim(),
          "description": _descriptionTEController.text.trim(),
          "status": "New",
        },
      );
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          showSnackMessage(context, "New Task Added");
        }
        widget.onTaskAdded?.call();
        Navigator.pop(context);
      } else {
        showSnackMessage(context, "failed to create new task", true);
      }
    }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
