import 'package:flutter/material.dart';
import 'package:project_sem2/core/utils/core.dart';

class ProductAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearch;
  final bool isGrid;
  final VoidCallback onToggleGrid;

  const ProductAppBar({
    super.key,
    required this.onSearch,
    required this.isGrid,
    required this.onToggleGrid,
  });

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProductAppBarState extends State<ProductAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      widget.onSearch('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.matcha,
      elevation: 3,
      title:
          _isSearching
              ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Cari produk...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black87),
                  onChanged: widget.onSearch,
                ),
              )
              : const Text(
                'Daftar Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
      actions: [
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            _isSearching ? _stopSearch() : _startSearch();
          },
        ),
        IconButton(
          icon: Icon(
            widget.isGrid ? Icons.list : Icons.grid_view,
            color: Colors.white,
          ),
          onPressed: widget.onToggleGrid,
        ),
      ],
    );
  }
}
