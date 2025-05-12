import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/data/model/item_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/bloc/bloc/item_details_bloc.dart';

class ItemDetailPage extends StatelessWidget {
  final int itemId;

  const ItemDetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemDetailsBloc()..add(Getdetails(itemId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          title: const Text('Detail Produk'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
          builder: (context, state) {
            if (state is ItemDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ItemDetailsFailure) {
              return Center(child: Text(state.message));
            }

            if (state is ItemDetailsLoaded) {
              final Items item = state.item;
              

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.photoUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              height: 250,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, size: 100),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? '',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.description ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.category_outlined,
                                  color: Colors.indigo,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.category ?? '-',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ), // Tambahkan jarak di sini
                            const SizedBox(height: 12), // Dan di sini
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.location ?? '-',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ), // Tambahkan jarak di sini
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  item.status == 'available'
                                      ? Icons.event_available
                                      : Icons
                                          .event_busy, // Pilih ikon sesuai status
                                  color:
                                      item.status == 'available'
                                          ? Colors.blue
                                          : Colors
                                              .red, // Warna biru jika available, merah jika unavailable
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.status ?? '-',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            item.status?.toLowerCase() == 'available'
                                ? () {
                                  final phoneNumber = item.user?.phone;
                                  if (phoneNumber != null &&
                                      phoneNumber.isNotEmpty) {
                                    final whatsappUrl =
                                        'https://wa.me/$phoneNumber';
                                    try {
                                      launchUrl(Uri.parse(whatsappUrl));
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Tidak dapat membuka WhatsApp",
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Nomor WhatsApp tidak tersedia",
                                        ),
                                      ),
                                    );
                                  }
                                }
                                : null, // Tombol akan disable jika status bukan "available"

                        icon: const Icon(Icons.chat_bubble_outline),
                        label: const Text("Hubungi Pemilik Barang"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), // Tambahkan jarak antara tombol

                    if (item.status?.toLowerCase() != 'available')
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Barang tidak tersedia',
                          style: TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
