import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final String description;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext?) deleteFunction;
  final VoidCallback onTap;

  TodoTile({
    super.key,
    required this.taskname,
    required this.description,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskname,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: taskCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          decoration: taskCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}