import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/bloc/bloc/bloc/my_item_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/item_detail_page.dart';
import '../widgets/myitem_card.dart';

class MyItemPage extends StatefulWidget {
  const MyItemPage({super.key});

  @override
  State<MyItemPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemPage> {
  @override
  void initState() {
    super.initState();
    // Panggil event saat halaman dibuka
    context.read<MyItemBloc>().add(GetMyItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            ); // kembali ke halaman sebelumnya (Settings Page)
          },
        ),
      ),

      body: BlocBuilder<MyItemBloc, MyItemState>(
        builder: (context, state) {
          if (state is MyItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyItemLoaded) {
            return GridView.builder(
              itemCount: state.myitems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final item = state.myitems[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(itemId: item.id),
                      ),
                    );
                  },
                  child: MyitemCard(myItems: item),
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
