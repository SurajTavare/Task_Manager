import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Controller/Task_controller.dart';

import '../../widgets/CustomTextField.dart';
import '../../widgets/Task_card.dart';
import 'AddEditTaskPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: RefreshIndicator(
        onRefresh: () async {
          taskController.loadTasks();
        },
        child: SingleChildScrollView(
          child: Container(
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
                Positioned(
                  top: -height * 0.12,
                  left: -width * 0.25,
                  child: Container(
                    width: width * 0.8,
                    height: width * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.purpleAccent.withOpacity(0.3),
                          Colors.purpleAccent.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.8, -0.82),
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.09,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.8, -0.7),
                  child: Text(
                    DateFormat('EEEE, d MMMM').format(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.055,
                      letterSpacing: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -height * 0.1,
                  right: -width * 0.2,
                  child: Container(
                    width: width * 0.7,
                    height: height * 0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.3),
                          Colors.blueAccent.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment(0, -0.43),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          filterChip('All', 'all',taskController),
                          filterChip('Incomplete', 'incomplete',taskController),
                          filterChip('Completed', 'completed', taskController),
                          SizedBox(width: 12),
                          filterChip('High', 'high', taskController, color: Colors.red),
                          filterChip('Med', 'medium',taskController, color: Colors.orange),
                          filterChip('Low', 'low', taskController,color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment(0, -0.58),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CustomTextField(
                        hintText: 'Search tasks...',
                        prefixIcon: Icons.search_rounded,
                        borderRadius: 16,
                        isSearch: true,
                        fontSize: 14,
                        isDense: true,
                        onChanged: (value) {
                          taskController.searchTask(value);
                        },
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: height * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Obx(() {
                        if (taskController.isLoading.value) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.purple, strokeWidth: 3),
                                SizedBox(height: 16),
                                Text(
                                  'Loading tasks...',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (taskController.searchTasks.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.task_alt_rounded,
                                    color: Colors.purple.shade300,
                                    size: 60,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  "No Task Yet!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, height * 0.12),
                          itemCount: taskController.searchTasks.length,
                          itemBuilder: (context, index) {
                            final task = taskController.searchTasks[index];
                            Color priorityColor = Colors.green.shade100;
                            Color priorityTextColor = Colors.green.shade800;

                            if (task.priority == 'high') {
                              priorityColor = Colors.red.shade100;
                              priorityTextColor = Colors.red.shade800;
                            }
                            if (task.priority == 'medium') {
                              priorityColor = Colors.orange.shade100;
                              priorityTextColor = Colors.orange.shade800;
                            }
                            if (task.priority == 'low') {
                              priorityColor = Colors.yellow.shade100;
                              priorityTextColor = Colors.yellow.shade800;
                            }

                            return Dismissible(
                              key: Key(task.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => taskController.deleteTask(task.id),
                              background: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.delete_rounded, color: Colors.white, size: 32),
                                    SizedBox(height: 4),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: TaskCard(
                                task: task,
                                completeTask: () => taskController.toggleComplete(task),
                                editTask: () => Get.to(() => AddEditTaskPage(task: task)),
                                priorityColor: priorityColor,
                                priorityTextColor: priorityTextColor,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),

                Positioned(
                  bottom: height * 0.03,
                  right: width * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.purple,
                      elevation: 0,
                      onPressed: () => Get.to(() => AddEditTaskPage()),
                      child: const Icon(Icons.add_rounded, size: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }






  Widget filterChip(String label, String value, TaskController controller, {Color? color}) {
    return Obx(() {
      final bool isSelected = controller.activeFilter.value == value;

      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: FilterChip(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : (color ?? Colors.purple.shade700),
            ),
          ),
          selected: isSelected,
          onSelected: (_) => controller.setFilter(value),
          backgroundColor: Colors.grey.shade100,
          selectedColor: color ?? Colors.purple, // Selected = Purple (or priority color)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? (color ?? Colors.purple)
                  : Colors.purple.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          showCheckmark: false,
        ),
      );
    });
  }
}
