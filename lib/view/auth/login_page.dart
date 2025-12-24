import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../Controller/login_controller.dart';
import '../../widgets/CustomTextField.dart';
import 'Register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController logincontroller = Get.put(LoginController());

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
                alignment: const Alignment(0, -0.8),
                child: Container(
                  width: width * 0.75,
                  height: width * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.shade100.withOpacity(0.3),
                        blurRadius: width * 0.1,
                        spreadRadius: width * 0.025,
                      ),
                    ],
                  ),
                  child: Hero(tag: 'lottie-task', child: Lottie.asset('assets/Task Done.json')),
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
                alignment: Alignment(0, 0.11),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.08, height * 0.39, width * 0.08, height * 0.1),
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3142),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                    CustomTextField(
                      controller: logincontroller.emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),

                    SizedBox(height: 15),
                      Obx(() => CustomTextField(
                        controller: logincontroller.passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: !logincontroller.isPasswordVisible.value,
                        suffixIcon: logincontroller.isPasswordVisible.value
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.visibility_off),
                        onSuffixTap: () {
                          logincontroller.isPasswordVisible.value =
                          !logincontroller.isPasswordVisible.value;
                        },
                      ),),
                      SizedBox(height: height * 0.04),
                      Obx(
                        ()=> ElevatedButton(
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
                            logincontroller.login();
                          },
                          child:
                          logincontroller.isLoading.value
                              ? CircularProgressIndicator.adaptive()
                              : Text(
                            'Login',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.04),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0, 0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.grey, fontSize: width * 0.045),
                    ),

                    InkWell(
                      onTap: () {
                        Get.to(
                          () => RegisterPage(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 800),
                          // curve: Curves.easeInOutCubic,
                        );
                      },
                      child: Text(
                        'Sign up',
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
