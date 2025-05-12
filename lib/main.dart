import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/bloc/get_item_bloc.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/datasource/auth_remote_datasource.dart';
import 'package:project_sem2/data/repository/auth_repository_impl.dart';
import 'package:project_sem2/domain/usecases/login_usecase.dart';
import 'package:project_sem2/domain/usecases/logout_usecase.dart';
import 'package:project_sem2/domain/usecases/register_usecase.dart';
import 'package:project_sem2/presentation/bloc/auth_bloc.dart';
import 'package:project_sem2/presentation/ui/bloc/bloc/favorit_bloc.dart';
import 'package:project_sem2/presentation/ui/bloc/recomends_bloc.dart';
import 'package:project_sem2/presentation/ui/pages/favorit_page.dart';
import 'package:project_sem2/presentation/ui/pages/my_item_page.dart';
import 'package:project_sem2/presentation/ui/pages/product_page.dart';
import 'package:project_sem2/presentation/ui/pages/recomends_page.dart';
import 'package:project_sem2/presentation/ui/pages/splash_page.dart';

import 'bloc/bloc/bloc/bloc/my_item_bloc.dart';

void main() {
  runApp(
    DevicePreview(
      // White background looks professional in website embedding
      backgroundColor: Colors.white,

      // Enable preview by default for web demo
      enabled: true,

      // Start with Galaxy A50 as it's a common Android device
      defaultDevice: Devices.ios.iPhone13ProMax,

      // Show toolbar to let users test different devices
      isToolbarVisible: true,

      // Keep English only to avoid confusion in demos
      availableLocales: [Locale('en', 'US')],

      // Customize preview controls
      tools: const [
        // Device selection controls
        DeviceSection(
          model: true, // Option to change device model to fit your needs
          orientation: false, // Lock to portrait for consistent demo
          frameVisibility: false, // Hide frame options
          virtualKeyboard: false, // Hide keyboard
        ),

        // Theme switching section
        // SystemSection(
        //   locale: false, // Hide language options - we're keeping it English only
        //   theme: false, // Show theme switcher if your app has dark/light modes
        // ),

        // Disable accessibility for demo simplicity
        // AccessibilitySection(
        //   boldText: false,
        //   invertColors: false,
        //   textScalingFactor: false,
        //   accessibleNavigation: false,
        // ),

        // Hide extra settings to keep demo focused
        // SettingsSection(
        //   backgroundTheme: false,
        //   toolsTheme: false,
        // ),
      ],

      // Curated list of devices for comprehensive preview
      devices: [
        // ... Devices.all, // uncomment to see all devices

        // Popular Android Devices
        Devices.android.samsungGalaxyA50, // Mid-range
        Devices.android.samsungGalaxyNote20, // Large screen
        Devices.android.samsungGalaxyS20, // Flagship
        Devices.android.samsungGalaxyNote20Ultra, // Premium
        Devices.android.onePlus8Pro, // Different aspect ratio
        Devices.android.sonyXperia1II, // Tall screen
        // Popular iOS Devices
        Devices.ios.iPhoneSE, // Small screen
        Devices.ios.iPhone12, // Standard size
        Devices.ios.iPhone12Mini, // Compact
        Devices.ios.iPhone12ProMax, // Large
        Devices.ios.iPhone13, // Latest standard
        Devices.ios.iPhone13ProMax, // Latest large
        Devices.ios.iPhone13Mini, // Latest compact
        Devices.ios.iPhoneSE, // Budget option
      ],

      /// Your app's entry point
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                LoginUseCase(AuthRepositoryImpl(AuthRemoteDatasource())),
                LogoutUsecase(AuthRemoteDatasource()),
                RegisterUseCase(AuthRepositoryImpl(AuthRemoteDatasource())),
                AuthLocalDatasource(),
                AuthRemoteDatasource(),
              ),
        ),

        BlocProvider(
          create: (context) => GetItemBloc()..add(OnGetItem()),
          child: const ProductPage(),
        ),

        BlocProvider(
          create: (context) => RecomendsBloc()..add(OnGetRecomends()),
          child: const RecommendationPage(),
        ),
        BlocProvider(
          create: (context) {
            final favoritBloc = FavoritBloc();
            AuthLocalDatasource().getToken().then((token) {
              if (token != null) {
                favoritBloc.add(LoadFavorit(token: token));
              } else {
                // Bisa kasih handling kalau token null
                print('Token tidak ditemukan');
              }
            });
            return favoritBloc;
          },
          child: const FavoritPage(),
        ),
        BlocProvider(
          create: (context) => MyItemBloc()..add(GetMyItems()),
          child: const MyItemPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Aplikasi Saya',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
