import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/model/task_model.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxList<TaskModel> searchTasks = <TaskModel>[].obs;

  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  final RxString activeFilter = 'all'.obs;

  void setFilter(String filter) {
    activeFilter.value = filter;
    applyFilters();
  }

  final RxString completionFilter = 'all'.obs;
  final RxString priorityFilter = 'all'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTasks();
    ever(activeFilter, (_) => applyFilters());
    ever(searchQuery, (_) => applyFilters());
    ever(tasks, (_) => applyFilters());
  }




  void loadTasks() {
    try {
      isLoading.value = true;
      final uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .orderBy('dueDate')
          .snapshots()
          .listen((snapshot) {
            final fetchedTasks = snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();

            tasks.value = fetchedTasks;
            // searchTasks.value = fetchedTasks;
            isLoading.value = false;
          });
    } catch (e) {
      isLoading.value = false;
      print("task fetching error ${e.toString()}");
    }
  }

  void applyFilters() {
    List<TaskModel> filtered = tasks;

    // Completion filters
    if (activeFilter.value == 'completed') {
      filtered = filtered.where((task) => task.isCompleted).toList();
    } else if (activeFilter.value == 'incomplete') {
      filtered = filtered.where((task) => !task.isCompleted).toList();
    }

    // Priority filters
    else if (activeFilter.value == 'high') {
      filtered = filtered.where((task) => task.priority == 'high').toList();
    } else if (activeFilter.value == 'medium') {
      filtered = filtered.where((task) => task.priority == 'medium').toList();
    } else if (activeFilter.value == 'low') {
      filtered = filtered.where((task) => task.priority == 'low').toList();
    }

    // Search
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((task) =>
      task.title.toLowerCase().contains(query) ||
          task.description.toLowerCase().contains(query)).toList();
    }

    searchTasks.value = filtered;
  }


  void setCompletionFilter(String filter) {
    completionFilter.value = filter;
  }

  void setPriorityFilter(String filter) {
    priorityFilter.value = filter;
  }

  void clearFilters() {
    completionFilter.value = 'all';
    priorityFilter.value = 'all';
    searchQuery.value = '';
  }

  void searchTask(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      searchTasks.value = tasks;
    } else {
      searchTasks.value = tasks.where((task) {
        final titleMatch = task.title.toLowerCase().contains(query.toLowerCase());
        final descMatch = task.description.toLowerCase().contains(query.toLowerCase());

        return titleMatch || descMatch;
      }).toList();
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .add(task.toFirestore());
      Get.snackbar(
        'Success',
        'Task added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("task adding error ${e.toString()}");
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(task.id)
          .update(task.toFirestore());
      Get.snackbar(
        'Success',
        'Task Updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("task updating error ${e.toString()}");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(id)
          .delete();

      Get.snackbar(
        'Success',
        'Task deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print("task deleting error ${e.toString()}");
    }
  }

  void toggleComplete(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }
}
