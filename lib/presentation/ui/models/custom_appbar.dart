import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/data/model/user_model.dart';
import 'package:project_sem2/presentation/bloc/auth_bloc.dart';

class ModernAppBar extends StatefulWidget {
  const ModernAppBar({super.key});

  @override
  State<ModernAppBar> createState() => _ModernAppBarState();
}

class _ModernAppBarState extends State<ModernAppBar> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(FetchCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background SVG
        SizedBox(
          width: double.infinity,
          height: 180,
          child: Image.asset(
            'assets/images/Announcement.png',
            fit: BoxFit.cover,
          ),
        ),

        // Avatar dan Greeting
        Positioned(
          left: 16,
          top: 70,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator(color: Colors.white);
              } else if (state is AuthLoaded) {
                UserModel user = state.user;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Good Morning,\n${user.name}!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is AuthFailure) {
                return const Text(
                  'gagal mengambil data user',
                  style: TextStyle(color: Colors.white),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
