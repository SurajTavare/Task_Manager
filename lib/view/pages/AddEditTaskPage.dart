import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controller/Task_controller.dart';
import '../../model/task_model.dart';
import '../../widgets/CustomTextField.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskModel? task;

  const AddEditTaskPage({super.key, this.task});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late String selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title ?? '');
    descriptionController = TextEditingController(text: widget.task?.description ?? '');
    selectedDate = widget.task?.dueDate ?? DateTime.now();
    selectedPriority = widget.task?.priority ?? 'medium';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF8F0),
              const Color(0xFFFFF5E9),
              const Color(0xFFFFEFDB),
              Colors.white,
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Bg Circles
            Positioned(
              top: -height * 0.08,
              right: -width * 0.25,
              child: Container(
                width: width * 0.7,
                height: width * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.purpleAccent.withOpacity(0.25),
                      Colors.purpleAccent.withOpacity(0.08),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -height * 0.1,
              left: -width * 0.2,
              child: Container(
                width: width * 0.6,
                height: width * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.15),
                      Colors.blueAccent.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Custom App Bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.015,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_rounded, color: Colors.purple),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.task == null ? 'Add New Task' : 'Edit Task',
                                style: TextStyle(
                                  fontSize: width * 0.065,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF2D3142),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                widget.task == null ? 'Create a new task' : 'Update task details',
                                style: TextStyle(
                                  fontSize: width * 0.038,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // task data
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SectionLabel('Task Title', required: true),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CustomTextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: titleController,
                              hintText: 'e.g., Complete Flutter Assignment',
                              prefixIcon: Icons.edit_rounded,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),

                          SectionLabel('Description', required: false),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CustomTextField(
                              controller: descriptionController,
                              textCapitalization: TextCapitalization.sentences,
                              hintText: 'Add some details about your task...',
                              maxLines: 4,
                              contentPadding: const EdgeInsets.all(20),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 24),

                          //  Date Picker
                          SectionLabel('Due Date', required: true),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),

                                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Colors.purple,
                                            onPrimary: Colors.white,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      selectedDate = picked;
                                    });
                                  }
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.purple.shade100, width: 1.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.purple,
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Due Date',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              DateFormat('EEEE, d MMMM yyyy').format(selectedDate),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF2D3142),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Priority
                          SectionLabel('Priority Level', required: true),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              PriorityChip('Low', 'Low', Colors.green),
                              const SizedBox(width: 12),
                              PriorityChip('Medium', 'Medium', Colors.orange),
                              const SizedBox(width: 12),
                              PriorityChip('High', 'High', Colors.red),
                            ],
                          ),
                          SizedBox(height: height * 0.05),

                          // Add task Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.purpleAccent],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () {
                                if (titleController.text.trim().isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Task title is required',
                                    backgroundColor: Colors.red.shade400,
                                    colorText: Colors.white,
                                    icon: const Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    borderRadius: 20,
                                    margin: const EdgeInsets.all(16),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                  return;
                                }

                                final newTask = TaskModel(
                                  id: widget.task?.id ?? '',
                                  title: titleController.text.trim(),
                                  description: descriptionController.text.trim(),
                                  dueDate: selectedDate,
                                  priority: selectedPriority,
                                  isCompleted: widget.task?.isCompleted ?? false,
                                );

                                if (widget.task == null) {
                                  taskController.addTask(newTask);
                                  Get.back();
                                  Get.snackbar(
                                    'Success',
                                    'Task added successfully',
                                    backgroundColor: Colors.green.shade400,
                                    colorText: Colors.white,
                                    icon: const Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    borderRadius: 20,
                                    margin: const EdgeInsets.all(16),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                } else {
                                  taskController.updateTask(newTask);
                                  Get.back();
                                  Get.snackbar(
                                    'Success',
                                    'Task updated successfully',
                                    backgroundColor: Colors.green.shade400,
                                    colorText: Colors.white,
                                    icon: const Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    borderRadius: 20,
                                    margin: const EdgeInsets.all(16),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.task == null
                                        ? Icons.add_circle_outline_rounded
                                        : Icons.check_circle_outline_rounded,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    widget.task == null ? 'Add Task' : 'Update Task',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SectionLabel(String label, {required bool required}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
            letterSpacing: -0.2,
          ),
        ),
        if (required)
          const Text(
            ' *',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red),
          ),
      ],
    );
  }

  Widget PriorityChip(String value, String label, Color color) {
    final isSelected = selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPriority = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            children: [
              Icon(Icons.flag_rounded, color: isSelected ? Colors.white : color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : color,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
