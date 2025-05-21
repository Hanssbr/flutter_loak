import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/presentation/ui/bloc/bloc/favorit_bloc.dart';
import 'package:project_sem2/presentation/ui/models/fav_appbar.dart';
import 'package:project_sem2/presentation/ui/widgets/favorit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  @override
  void initState() {
    super.initState();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      context.read<FavoritBloc>().add(LoadFavorit(token: token));
    } else {
      // Bisa tampilkan pesan error atau redirect ke login
      debugPrint("Token not found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FavAppbar(title: 'Favorite Page'),
      body: BlocBuilder<FavoritBloc, FavoritState>(
        builder: (context, state) {
          if (state is FavoritLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritLoaded) {
            if (state.favorits.isEmpty) {
              return const Center(child: Text("Belum ada item favorit."));
            }
            return ListView.builder(
              itemCount: state.favorits.length,
              itemBuilder: (context, index) {
                return FavoritCard(favoritItem: state.favorits[index].item);
              },
            );
          } else {
            return const Center(child: Text("No data or failed to load."));
          }
        },
      ),
    );
  }
}
