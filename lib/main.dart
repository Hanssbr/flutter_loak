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
import 'package:project_sem2/presentation/ui/pages/product_page.dart';
import 'package:project_sem2/presentation/ui/pages/recomends_page.dart';
import 'package:project_sem2/presentation/ui/pages/splash_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

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
