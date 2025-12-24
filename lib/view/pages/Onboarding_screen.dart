import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Controller/Onboarding_screen_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController controller = Get.put(OnboardingScreenController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
            Positioned(
              bottom: height * 0.06,
              right: width * 0.08,
              child: Container(
                width: width * 0.25,
                height: width * 0.25,

                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: controller.goToScreen,
                  child: Icon(Icons.arrow_forward_rounded, size: width * 0.09),
                ),
              ),
            ),

            Align(
              alignment: const Alignment(0, -0.5),
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
              alignment: const Alignment(-0.55, -0.25),
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
              alignment: const Alignment(0.65, 0.5),
              child: _buildDot(8, Colors.blue.shade100, BoxShape.circle),
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get things done.',
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3142),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Just a click away from',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.blue,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'planning your tasks.',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.blue,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
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
