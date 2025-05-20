import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/get_item_bloc.dart';
import 'package:project_sem2/data/model/item_model.dart';
import 'package:project_sem2/presentation/ui/models/product_appbar.dart';
import 'package:project_sem2/presentation/ui/widgets/product_card.dart';



class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    // Memicu pengambilan data saat halaman dimuat
    context.read<GetItemBloc>().add(OnGetItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(
        onSearch: (keyword) {
          context.read<GetItemBloc>().add(SearchItem(keyword: keyword));
        },
        isGrid: _isGrid,
        onToggleGrid: () {
          setState(() {
            _isGrid = !_isGrid;
          });
        },
      ),
      body: BlocBuilder<GetItemBloc, GetItemState>(
        builder: (context, state) {
          if (state is GetItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetItemLoaded) {
            if (state.items.isEmpty) {
              return const Center(child: Text('Tidak ada items ditemukan'));
            }

            return _isGrid ? _buildGrid(state.items) : _buildList(state.items);
          } else {
            return const Center(child: Text('Gagal memuat items.'));
          }
        },
      ),
    );
  }

  // Tampilan List
  Widget _buildList(List<Items> items) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProductCard(product: items[index], isGrid: false);
      },
    );
  }

  // Tampilan Grid
  Widget _buildGrid(List<Items> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 0.65,
          child: ProductCard(product: items[index], isGrid: true),
        );
      },
    );
  }
}
