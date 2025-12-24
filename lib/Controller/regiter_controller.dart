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
      isLoading.value = false;
      Get.offAllNamed('/login');
    }
    on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String message = 'Registration failed. Please try again.';

      if (e.code == 'weak-password') {
        message = 'Password is too weak. Use at least 6 characters.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format. Please check your email.';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered. Try logging in.';
      } else {
        message = e.message ?? message;
      }

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      print('Firebase Error: ${e.code} - ${e.message}');
    }

    catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error${e.toString()}');
    }
    finally {

      isLoading.value = false;
    }
  }
}
