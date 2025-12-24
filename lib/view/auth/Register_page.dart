import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../Controller/regiter_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                right: -width * 0.25,
                child: Container(
                  width: width * 0.75,
                  height: width * 0.75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purpleAccent.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: -height * 0.1,
                left: -width * 0.2,
                child: Container(
                  width: width * 0.6,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orangeAccent.withOpacity(0.3),
                  ),
                ),
              ),

              Align(
                alignment: const Alignment(-0.4, -0.65),
                child: _buildDot(8, Colors.orange.shade300, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(0.5, -0.55),
                child: _buildDot(10, Colors.amber.shade200, BoxShape.rectangle),
              ),
              Align(
                alignment: const Alignment(-0.5, -0.35),
                child: _buildDot(6, Colors.amber.shade100, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(0.45, -0.3),
                child: _buildDot(12, Colors.indigo.shade900, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(0.6, -0.5),
                child: _buildDot(8, Colors.indigo.shade300, BoxShape.rectangle),
              ),
              Align(
                alignment: const Alignment(-0.35, -0.25),
                child: _buildDot(10, Colors.blue.shade200, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(-0.7, -0.8),
                child: _buildDot(5, Colors.orange.shade100, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(0.7, -0.7),
                child: _buildDot(7, Colors.amber.shade100, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(-0.6, 0.6),
                child: _buildDot(6, Colors.indigo.shade100, BoxShape.circle),
              ),
              Align(
                alignment: const Alignment(0.65, 0.4),
                child: _buildDot(8, Colors.blue.shade100, BoxShape.circle),
              ),

              Align(
                alignment: Alignment(0, 0.19),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: TextField(
                        controller: registerController.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: TextField(
                          controller: registerController.passwordController,
                          obscureText: !registerController.isPasswordVisible.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerController.isPasswordVisible.value =
                                    !registerController.isPasswordVisible.value;
                              },
                              icon: registerController.isPasswordVisible.value
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: TextField(
                          controller: registerController.confirmPasswordController,
                          obscureText: !registerController.isConfirmPasswordVisible.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerController.isConfirmPasswordVisible.value =
                                    !registerController.isConfirmPasswordVisible.value;
                              },
                              icon: registerController.isConfirmPasswordVisible.value
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400,
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.blue.withOpacity(0.4),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.2,
                            vertical: height * 0.02,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          registerController.register();
                        },
                        child: registerController.isLoading.value
                            ? CircularProgressIndicator.adaptive()
                            : Text(
                                'Sign up',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),

                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),

              Align(
                alignment: Alignment(0, 0.55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already an account? ',
                      style: TextStyle(color: Colors.grey, fontSize: width * 0.045),
                    ),

                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(double size, Color color, BoxShape shape) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 4, spreadRadius: 1)],
      ),
    );
  }
}
