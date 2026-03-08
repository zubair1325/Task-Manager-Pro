import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';
import 'package:task_manager_pro/ui/widget/task_item_card.dart';

class CancelTask extends StatefulWidget {
  const CancelTask({super.key});

  @override
  _CancelTaskState createState() => _CancelTaskState();
}

class _CancelTaskState extends State<CancelTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  // return TaskItemCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
