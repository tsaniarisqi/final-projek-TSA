import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/database/goal.dart';

class EditGoal extends StatefulWidget {
  final documentId;
  final int goal;
  const EditGoal({
    Key? key,
    this.documentId,
    required this.goal,
  }) : super(key: key);

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  late var goalController = TextEditingController();
  // int goal = 0;

  @override
  void initState() {
    super.initState();
    goalController = TextEditingController(
      text: widget.goal.toString(),
    );
  }

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Your Goals"),
              content: TextFormField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Goals in this year',
                ),
                controller: goalController,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    var now = DateTime.now();
                    var yearFormate = DateFormat('yyyy').format(now);
                    await Goal.updateGoal(
                      year: yearFormate,
                      goal: int.tryParse(goalController.text),
                      docID: widget.documentId,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Goals update successfully',
                        ),
                      ),
                    );
                  },
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.edit,
          size: 10,
        ),
      ),
    );
  }
}
