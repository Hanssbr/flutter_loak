import 'package:flutter/material.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({super.key});

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
                'Log in',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Login to continue to your account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
