import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/presentation/ui/bloc/bloc/favorit_bloc.dart';
import 'package:project_sem2/presentation/ui/widgets/favorit_card.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritBloc, FavoritState>(
        builder: (context, state) {
          if (state is FavoritLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritLoaded) {
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
