import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback completeTask;
  final VoidCallback editTask;
  final Color priorityColor;
  final Color priorityTextColor;


  const TaskCard({
    super.key,
    required this.task,
    required this.completeTask,
    required this.priorityColor,
    required this.priorityTextColor,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: task.isCompleted
                ? Colors.grey.withOpacity(0.1)
                : Colors.purple.withOpacity(0.01),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: GestureDetector(
          onTap: completeTask,
          child: AnimatedContainer(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: task.isCompleted ? Colors.purple : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: task.isCompleted ? Colors.purple : Colors.grey, width: 2),
              boxShadow: task.isCompleted
                  ? [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            duration: const Duration(milliseconds: 200),
            child: task.isCompleted
                ? Icon(Icons.check_rounded, color: Colors.white, size: 20)
                : null,
          ),
        ),

        title: Text(
          task.title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, letterSpacing: -0.2),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: task.isCompleted ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: task.isCompleted ? Colors.grey.shade400 : Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('EEE, d MMM yyyy').format(task.dueDate),
                    style: TextStyle(
                      color:  task.isCompleted ? Colors.grey.shade600 : DateFormat('EEE, d MMM yyyy').format(task.dueDate) ==  DateFormat('EEE, d MMM yyyy').format(DateTime.now()) ? Colors.red :  Colors.grey.shade600 ,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: priorityColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: priorityTextColor.withOpacity(0.3), width: 1),
          ),

          child: Text(
            task.priority.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: priorityTextColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        onTap: editTask,
      ),
    );
  }
}
