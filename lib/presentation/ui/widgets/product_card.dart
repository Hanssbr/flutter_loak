import 'package:flutter/material.dart';
import 'package:project_sem2/data/datasource/favorit_datasource.dart';
import 'package:project_sem2/data/datasource/favorite_local_datasource.dart';
import 'package:project_sem2/data/model/item_model.dart';

class ProductCard extends StatefulWidget {
  final Items product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final favoriteLocal = FavoriteLocalDatasource();

  bool isFavorited = false;
  @override
  void initState() {
    super.initState();
    loadFavoriteStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFavoriteStatus(); // dipanggil ulang setiap kali halaman "muncul kembali"
  }

  void loadFavoriteStatus() async {
    final local = FavoritDatasource();
    final status = await local.checkFavoriteStatusFromApi(widget.product.id);
    setState(() {
      isFavorited = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dan tombol favorit dalam Stack
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.network(
                    widget.product.photoUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              // Tombol favorite di atas gambar
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      final newStatus = !isFavorited;

                      await favoriteLocal.saveFavoriteStatus(
                        widget.product.id.toString(),
                        newStatus,
                      );

                      setState(() {
                        isFavorited = newStatus;
                      });

                      favoriteItem(widget.product.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Informasi produk
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.product.description ?? 'No description available',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      widget.product.category ?? 'Uncategorized',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      widget.product.location ?? 'Unknown',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
