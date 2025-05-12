import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_sem2/core/utils/core.dart';
import 'package:project_sem2/presentation/bloc/auth_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/login_page.dart';
import 'package:project_sem2/presentation/ui/pages/my_item_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogout) {
          context.pushAndRemoveUntil(const LoginPage(), (route) => false);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 16),
            _buildSettingItem(
              context,
              icon: Assets.icons.box.path,
              title: 'My Items',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyItemPage()),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.star_border,
              title: 'Rate App',
              onTap: () {},
            ),
            _buildSettingItem(
              context,
              icon: Icons.share_outlined,
              title: 'Share App',
              onTap: () {},
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSettingItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            _buildSettingItem(
              context,
              icon: Icons.description_outlined,
              title: 'Terms and Conditions',
              onTap: () {},
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSettingItem(
              context,
              icon: Icons.email_outlined,
              title: 'Contact Us',
              onTap: () {},
            ),
            _buildSettingItem(
              context,
              icon: Icons.feedback_outlined,
              title: 'Feedback',
              onTap: () {},
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSettingItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.redAccent,
              onTap: () => _showLogoutDialog(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
        backgroundColor: const Color(0xFFF9F9F9),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required dynamic icon, // Bisa menerima IconData atau String (untuk gambar)
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child:
            icon is IconData
                ? Icon(icon, color: color) // Jika IconData, gunakan Icon widget
                : icon is String
                ? SvgPicture.asset(
                  icon, // Jika String, gunakan gambar SVG
                  width: 24,
                  height: 24,
                )
                : const Icon(
                  Icons.error,
                  color: Colors.red,
                ), // Default jika tidak sesuai
      ),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
