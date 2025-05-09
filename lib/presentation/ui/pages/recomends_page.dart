import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/item_detail_page.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ModernAppBar(),
      ),
      body: BlocBuilder<RecomendsBloc, RecomendsState>(
        builder: (context, state) {
          if (state is RecomendsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecomendsLoaded) {
            return GridView.builder(
              itemCount: state.recomendsItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final item = state.recomendsItems[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(itemId: item.id),
                      ),
                    );
                  },
                  child: RecomendCard(recomendItems: item),
                );
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
