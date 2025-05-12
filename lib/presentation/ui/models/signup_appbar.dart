import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_sem2/core/utils/constants/colors.gen.dart';
import 'package:project_sem2/presentation/ui/pages/login_page.dart';

class SignupAppbar extends StatelessWidget {
  const SignupAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset('assets/images/authBar.png', fit: BoxFit.cover),
        ),
        // Background atau konten lainnya
        Positioned(
          top: 70, // Atur posisi dari atas
          left: 20, // Atur posisi dari kiri
          right: 20, // Agar widget tetap responsif
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
