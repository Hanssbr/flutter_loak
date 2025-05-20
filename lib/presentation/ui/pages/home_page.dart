import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/get_item_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/create_item_page.dart';
import 'package:project_sem2/presentation/ui/pages/favorit_page.dart';
import 'package:project_sem2/presentation/ui/pages/product_page.dart';
import 'package:project_sem2/presentation/ui/pages/recomends_page.dart';
import 'package:project_sem2/presentation/ui/pages/settings_page.dart';
import 'package:project_sem2/presentation/ui/widgets/nav_item.dart';

import '../../../bloc/bloc/create_item_bloc.dart';
import '../../../core/utils/core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    RecommendationPage(),
    ProductPage(),
    FavoritPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                    create: (_) => CreateItemBloc(),
                    child: const CreateItemPage(),
                  ),
            ),
          );

          if (result == true) {
            // Refresh data jika produk berhasil dibuat
            context.read<GetItemBloc>().add(OnGetItem());
          }
        },
        backgroundColor: AppColors.greenLime,
        elevation: 0,
        shape: const CircleBorder(),
        child: Assets.icons.add.svg(width: 24, height: 24, color: Colors.white),
      ),

      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Nav Items kiri
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    iconPath: Assets.icons.home.path,
                    label: 'Home',
                    isActive: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                  ),
                  NavItem(
                    iconPath: Assets.icons.box.path,
                    label: 'Boxes',
                    isActive: _selectedIndex == 1,
                    onTap: () => _onItemTapped(1),
                  ),
                ],
              ),
            ),
            // Spacer untuk FAB
            const SizedBox(width: 40),
            // Nav Items kanan
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    iconPath: Assets.icons.star.path,
                    label: 'Favorit',
                    isActive: _selectedIndex == 2,
                    onTap: () => _onItemTapped(2),
                  ),
                  NavItem(
                    iconPath: Assets.icons.user.path,
                    label: 'profile',
                    isActive: _selectedIndex == 3,
                    onTap: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
