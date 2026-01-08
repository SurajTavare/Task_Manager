import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/task_model.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxList<TaskModel> filteredTasks = <TaskModel>[].obs;

  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString activeFilter = 'all'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTask();
  }

  void searchTask(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredTasks.value = tasks;
    } else {
      filteredTasks.value = tasks.where((tasks) {
        final titleMatch = tasks.title.toLowerCase().contains(query.toLowerCase());
        final descMatch = tasks.description.toLowerCase().contains(query.toLowerCase());
        return titleMatch || descMatch;
      }).toList();
    }
  }

  void setFilter(String filter) {
    activeFilter.value = filter;
    applyFilters();
  }

  void applyFilters() {
    if (activeFilter.value == 'completed') {
      filteredTasks.value = tasks.where((task) => task.isCompleted).toList();
      return;
    } else if (activeFilter.value == 'incomplete') {
      filteredTasks.value = tasks.where((task) => !task.isCompleted).toList();
      return;
    } else if (activeFilter.value == 'High') {
      filteredTasks.value = tasks.where((task) => task.priority == 'High').toList();
      return;
    } else if (activeFilter.value == 'Medium') {
      filteredTasks.value = tasks.where((task) => task.priority == 'Medium').toList();
      return;
    } else if (activeFilter.value == 'Low') {
      filteredTasks.value = tasks.where((task) => task.priority == 'Low').toList();
      return;
    } else {
      filteredTasks.value = tasks;
    }
  }

  void toggleComplete(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }

  Future<void> loadTask() async {
    if (isLoading.value) return;
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      isLoading.value = true;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .orderBy('dueDate')
          .snapshots()
          .listen((snapshot) {
            tasks.value = snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();
            filteredTasks.value = tasks;
          });

    } catch (e) {
      isLoading.value = false;
      print("task fetching error ${e.toString()}");
    } finally {
      isLoading.value = false;
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
        'Task Added successfully',
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
}



