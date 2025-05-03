import 'package:flutter/material.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/presentation/ui/pages/home_page.dart';

import '../../../core/utils/core.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _local = AuthLocalDatasource();

  @override
  void initState() {
    super.initState();
    _authCheck();
  }

  Future<void> _authCheck() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await _local.getToken();
    print("Token: $token");

    if (!mounted) return;
    if (token != null) {
      context.pushReplacement(const HomePage());
    } else {
      context.pushReplacement(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.matcha,
      body: Center(
        child: Assets.icons.logo.svg(
          // ini penting banget!
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

  // Widget _buildCircle(double size, Color color) {
  //   return Container(
  //     width: size,
  //     height: size,
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.8),
  //       shape: BoxShape.circle,
  //     ),
  //   );
  // }

