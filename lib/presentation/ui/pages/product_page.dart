import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/get_item_bloc.dart';
import 'package:project_sem2/presentation/ui/widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Panggil event saat halaman dibuka
    context.read<GetItemBloc>().add(OnGetItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Produk")),
      body: BlocBuilder<GetItemBloc, GetItemState>(
        builder: (context, state) {
          if (state is GetItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetItemLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return ProductCard(product: state.items[index]);
              },
            );
          } else {
            return const Center(child: Text('Gagal memuat produk.'));
          }
        },
      ),
    );
  }
}
