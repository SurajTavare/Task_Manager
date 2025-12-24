import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty){
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text){
      Get.snackbar(
        'Error',
        'Please check password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
