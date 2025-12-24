import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/auth/login_page.dart';
import '../view/pages/Home_page.dart';

class OnboardingScreenController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  void goToScreen() {
    final user = FirebaseAuth.instance.currentUser;
    Get.off(
      () {
        return user != null ? const HomePage() : const LoginPage();
      },
      transition: Transition.rightToLeftWithFade,

      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }
}
