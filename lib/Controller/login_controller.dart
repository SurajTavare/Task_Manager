import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoading.value = false;
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String message = 'Registration failed. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email. Please register first.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid email or password. Please check and try again.';
      } else if (e.code == 'user-disabled') {
        message = 'This account has been disabled.';
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

  Future<void> logout()async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');

  }
}
