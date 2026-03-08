import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';
import 'package:task_manager_pro/ui/widget/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  _ProgressTaskScreenState createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
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
