import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_sem2/core/utils/core.dart';
import 'package:project_sem2/data/model/user_model.dart';
import 'package:project_sem2/presentation/bloc/auth_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/login_page.dart';
import 'package:project_sem2/presentation/ui/pages/my_item_page.dart';
import 'package:project_sem2/presentation/ui/pages/privacy_policy_page.dart';
import 'package:project_sem2/presentation/ui/pages/profile_page.dart';
import 'package:project_sem2/presentation/ui/pages/terms_conditions_page.dart';

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
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            UserModel? user;

            if (state is AuthSuccess) {
              user = state.user;
            } else if (state is AuthLoaded) {
              user = state.user;
            }

            return ListView(
              children: [
                _buildSettingItem(
                  context,
                  icon: Assets.icons.user.path,
                  title: 'My Profile',
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UpdateProfilePage(
                              initialName: user?.name ?? '',
                              initialEmail: user?.email ?? '',
                              initialPhone: user?.phone ?? '',
                              initialPhotoUrl: user?.photoUrl,
                            ),
                      ),
                    );

                    if (result == true) {
                      context.read<AuthBloc>().add(FetchCurrentUser());
                    }
                  },
                ),
                _buildSettingItem(
                  context,
                  icon: Assets.icons.box.path,
                  title: 'My Items',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyItemPage(),
                      ),
                    );
                  },
                ),
                const Divider(indent: 16, endIndent: 16),
                _buildSettingItem(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Terms and Conditions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsConditionsPage(),
                      ),
                    );
                  },
                ),
                const Divider(indent: 16, endIndent: 16),
                _buildSettingItem(
                  context,
                  icon: Icons.email_outlined,
                  title: 'Contact Us',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Hubungi Kami'),
                          content: Text(
                            'Silakan hubungi kami melalui email di:\nGiveBox@mail.com',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
            );
          },
        ),
        backgroundColor: const Color(0xFFF9F9F9),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required dynamic icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child:
            icon is IconData
                ? Icon(icon, color: color)
                : icon is String
                ? SvgPicture.asset(icon, width: 24, height: 24)
                : const Icon(Icons.error, color: Colors.red),
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
