import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/bloc/bloc/bloc/my_item_bloc.dart';
import 'package:project_sem2/data/model/myitem_model.dart';
import 'package:project_sem2/presentation/ui/pages/item_detail_page.dart';

class MyitemCard extends StatefulWidget {
  final MyItems myItems;

  const MyitemCard({super.key, required this.myItems});

  @override
  State<MyitemCard> createState() => _MyItemCardState();
}

class _MyItemCardState extends State<MyitemCard> {
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Hapus Item'),
            content: const Text('Apakah kamu yakin ingin menghapus item ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  context.read<MyItemBloc>().add(
                    DeleteMyItem(widget.myItems.id),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
  }

  void _updateItemStatus(BuildContext context) {
    final newStatus =
        widget.myItems.status == 'available' ? 'unavailable' : 'available';
    context.read<MyItemBloc>().add(
      UpdateItemStatus(itemId: widget.myItems.id.toString(), status: newStatus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ItemDetailPage(itemId: widget.myItems.id),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Image.network(
                            widget.myItems.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
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
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () => _confirmDelete(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.myItems.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),

                        // Update Status Button
                        ElevatedButton(
                          onPressed: () => _updateItemStatus(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                widget.myItems.status == "available"
                                    ? Colors.red
                                    : Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ), // Menambahkan warna teks putih
                          ),
                          child: Text(
                            widget.myItems.status == "available"
                                ? "Unavailable"
                                : "Available",
                            style: TextStyle(
                              color: Colors.white,
                            ), // Menambahkan warna teks putih di sini jika perlu
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
