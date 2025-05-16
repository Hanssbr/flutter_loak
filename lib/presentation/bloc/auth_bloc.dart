import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/datasource/auth_remote_datasource.dart';
import 'package:project_sem2/data/model/user_model.dart';
import 'package:project_sem2/domain/usecases/login_usecase.dart';
import 'package:project_sem2/domain/usecases/logout_usecase.dart';
import 'package:project_sem2/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUsecase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final AuthLocalDatasource authLocalDatasource;
  final AuthRemoteDatasource authRemoteDatasource;

  AuthBloc(
    this.loginUseCase,
    this.logoutUseCase,
    this.registerUseCase,
    this.authLocalDatasource,
    this.authRemoteDatasource,
  ) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);

        print('Login berhasil:');
        print('Token: ${result['token']}');
        print('User: ${result['user']}');
        await authLocalDatasource.saveToken(result['token']);
        emit(AuthSuccess(result['user'], result['token']));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await logoutUseCase();
        emit((AuthLogout()));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await registerUseCase.call(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        );
        await authLocalDatasource.saveToken(result['token']);
        emit(AuthSuccess(result['user'], result['token']));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<FetchCurrentUser>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authLocalDatasource.getToken();
        if (token == null) throw Exception('Token tidak ditemukan');
        final user = await authRemoteDatasource.getCurrentUser(token);
        emit(AuthLoaded(user));
      } catch (e) {
        await authLocalDatasource.clearToken(); // hapus token jika error
        emit(AuthFailure(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(UserLoading());

      try {
        final token = await AuthLocalDatasource().getToken();
        if (token == null) {
          emit(UserFailure('Token tidak ditemukan'));
          return;
        }

        final result = await authRemoteDatasource.updateProfile(
          token: token,
          name: event.name,
          email: event.email,
          phone: event.phone,
          photoBytes: event.photo, // Uint8List? bisa null
          photoFilename: event.photoFilename ?? 'profile_photo.png',
        );

        print('RESPON UPDATE PROFILE: $result'); // debug dulu

        if (result['data'] == null) {
          throw Exception('Data user tidak ditemukan di response');
        }

        final user = UserModel.fromJson(result['data']);
        emit(UserUpdatedSuccess(user));
        emit(AuthLoaded(user));
      } catch (e) {
        emit(UserFailure(e.toString()));
      }
    });
  }
}
