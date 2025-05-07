import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recomends_bloc.dart';
import '../models/custom_appbar.dart';
import '../widgets/recomend_card.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  @override
  void initState() {
    super.initState();
    // Panggil event saat halaman dibuka
    context.read<RecomendsBloc>().add(OnGetRecomends());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModernAppBar(title: 'Recommendations', showBackButton: true),
      body: BlocBuilder<RecomendsBloc, RecomendsState>(
        builder: (context, state) {
          if (state is RecomendsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecomendsLoaded) {
            print(state.recomendsItems);
            return ListView.builder(
              itemCount: state.recomendsItems.length,
              itemBuilder: (context, index) {
                return RecomendCard(recomendItems: state.recomendsItems[index]);
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
