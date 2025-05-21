import 'package:flutter/material.dart';
import 'package:project_sem2/core/utils/constants/colors.dart';

class FavAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const FavAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: AppColors.matcha,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
