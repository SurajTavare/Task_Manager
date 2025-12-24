import 'package:get/get.dart';
import 'package:task_manager/view/auth/Register_page.dart';
import 'package:task_manager/view/auth/login_page.dart';
import 'package:task_manager/view/pages/Home_page.dart';
import 'package:task_manager/view/pages/Onboarding_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';



  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const OnboardingScreen()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: signup, page: () => const RegisterPage()),
    GetPage(name: home, page: () => const HomePage()),
  ];
}
